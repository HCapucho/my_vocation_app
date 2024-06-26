import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_vocation_app/core/core.dart';
import 'package:my_vocation_app/core/helpers/loader.dart';
import 'package:my_vocation_app/core/helpers/messages.dart';
import 'package:my_vocation_app/modules/home/widgets/appbar/app_bar_widget.dart';
import 'package:my_vocation_app/modules/quiz/infra/dtos/resposta_questionario_dto.dart';
import 'package:my_vocation_app/modules/result/domain/bloc/result_bloc.dart';
import 'package:my_vocation_app/modules/result/domain/models/curso.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultPage extends StatefulWidget {
  final int idQuestionario;
  final String title;
  final List<RespostaQuestionarioDto> respostas;

  const ResultPage({
    Key? key,
    required this.idQuestionario,
    required this.title,
    required this.respostas,
  }) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with Messages<ResultPage>, Loader<ResultPage> {
  late final ResultBloc bloc;
  String? username;
  late List<bool> _expanded;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ResultBloc>();
    _getName();
    _finishQuiz();
    _expanded = [];
  }

  _getName() async {
    final sp = await SharedPreferences.getInstance();
    username = sp.getString('username');
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  void _finishQuiz() async {
    var sp = await SharedPreferences.getInstance();
    var idUsuario = sp.getInt("idUser");

    bloc.add(FinishQuizEvent(
      idUsuario: idUsuario!,
      idQuestionario: widget.idQuestionario,
      respostas: widget.respostas,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ResultBloc, ResultState>(listener: (context, state) {
        if (state is FinishQuizInProgress) {
          showLoader();
        }
        if (state is FinishQuizFailure) {
          hideLoader();
          showError(state.errorMessage);
        }
        if (state is FinishQuizSuccess) {
          setState(() {
            _expanded = List.generate(state.cursos.length, (index) => false);
          });
          hideLoader();
        }
      }, buildWhen: (context, state) {
        return state is FinishQuizSuccess;
      }, builder: (context, state) {
        if (state is FinishQuizInProgress) {
          return Container();
        }
        if (state is FinishQuizFailure) {
          return Container();
        }
        if (state is FinishQuizSuccess) {
          return Scaffold(
            appBar: AppBarWidget(username: username!),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text("Melhores Cursos", style: AppTextStyles.heading30),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cursos.length,
                      itemBuilder: (context, index) {
                        return ExpansionPanelList(
                          expansionCallback: (int panelIndex, bool isExpanded) {
                            setState(() {
                              _expanded[index] = !_expanded[index];
                            });
                          },
                          children: [
                            ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text(state.cursos[index].nome),
                                );
                              },
                              body: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  children: state.cursos[index].universidades
                                      .map((item) => Text(item,
                                          style: AppTextStyles.body11))
                                      .toList(),
                                ),
                              ),
                              isExpanded: _expanded[index],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      }),
    );
  }
}


// Container(
//         width: double.maxFinite,
//         padding: EdgeInsets.only(top: 100),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(AppImages.trophy),
//             Column(
//               children: [
//                 Text(
//                   'Parabéns!',
//                   style: AppTextStyles.heading40,
//                 ),
//                 SizedBox(height: 16),
//                 Text.rich(
//                   TextSpan(
//                     text: "Você concluiu",
//                     style: AppTextStyles.body,
//                     children: [
//                       TextSpan(
//                         text: "\n$title",
//                         style: AppTextStyles.bodyBold,
//                       ),
//                       TextSpan(
//                         text: "\ncom somatório de $result.",
//                         style: AppTextStyles.body,
//                       ),
//                     ],
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 68),
//                         child: NextButtonWidget.purple(
//                             label: "Compartilhar",
//                             onTap: () {
//                               Share.share(
//                                   'MyVocation \n Questionário: $title\n Resultado: $result');
//                             }),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 24),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 68),
//                         child: NextButtonWidget.white(
//                           label: "Voltar ao início",
//                           onTap: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),