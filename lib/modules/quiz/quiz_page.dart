import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_vocation_app/core/helpers/loader.dart';
import 'package:my_vocation_app/core/helpers/messages.dart';
import 'package:my_vocation_app/modules/home/domain/bloc/home_bloc.dart';
import 'package:my_vocation_app/modules/quiz/domain/bloc/quiz_bloc.dart';
import 'package:my_vocation_app/modules/quiz/domain/models/enums/tipo_resposta.dart';
import 'package:my_vocation_app/modules/quiz/domain/models/pergunta.dart';
import 'package:my_vocation_app/modules/quiz/infra/dtos/resposta_questionario_dto.dart';
import 'package:my_vocation_app/modules/quiz/quiz_controller.dart';
import 'package:my_vocation_app/modules/quiz/widgets/next_button/next_button_widget.dart';
import 'package:my_vocation_app/modules/quiz/widgets/question_indicator/question_indicator_widget.dart';
import 'package:my_vocation_app/modules/quiz/widgets/quiz/quiz_widget.dart';
import 'package:my_vocation_app/modules/result/result_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizPage extends StatefulWidget {
  final int idQuestionario;
  final int quantidadePerguntas;
  final String nome;
  const QuizPage({
    Key? key,
    required this.idQuestionario,
    required this.quantidadePerguntas,
    required this.nome,
  }) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with Messages<QuizPage>, Loader<QuizPage> {
  late final QuizBloc bloc;
  final controller = QuizController();
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });
    bloc = context.read<QuizBloc>();
    _startQuiz();
    _getQuestions();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  void _getQuestions() {
    bloc.add(GetQuestionsEvent(widget.idQuestionario));
  }

  void _startQuiz() async {
    var sp = await SharedPreferences.getInstance();
    var idUsuario = sp.getInt("idUser");

    bloc.add(StartQuizEvent(idUsuario!, widget.idQuestionario));
  }

  void nextPage() {
    if (controller.currentPage < widget.quantidadePerguntas) {
      pageController.nextPage(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }
  }

  void onSelected(int value, int idPergunta) {
    final resposta = RespostaQuestionarioDto(
        idPergunta: idPergunta, resposta: TipoResposta.values[value]);
    controller.respostas.add(resposta);
    nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(86),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
              ),
              ValueListenableBuilder<int>(
                  valueListenable: controller.currentPageNotifier,
                  builder: (context, value, _) => QuestionIndicatorWidget(
                        currentPage: value,
                        length: widget.quantidadePerguntas,
                      )),
            ],
          ),
        ),
      ),
      body: BlocConsumer<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state is GetQuestionsInProgress) {
            showLoader();
          }
          if (state is GetQuestionsFailure) {
            hideLoader();
            showError(state.errorMessage);
          }
          if (state is GetQuestionsSuccess) {
            hideLoader();
          }
        },
        buildWhen: (context, state) {
          return state is GetQuestionsSuccess;
        },
        builder: (context, state) {
          if (state is GetQuestionsInProgress) {
            return Container();
          }
          if (state is GetQuestionsFailure) {
            return Container();
          }
          if (state is GetQuestionsSuccess) {
            return PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: state.questions
                  .map((e) => QuizWidget(
                        question: e,
                        onTap: onSelected,
                      ))
                  .toList(),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ValueListenableBuilder<int>(
            valueListenable: controller.currentPageNotifier,
            builder: (context, value, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (value == widget.quantidadePerguntas)
                  Expanded(
                    child: NextButtonWidget.green(
                      label: "Confirmar",
                      onTap: () {
                        for (var element in controller.respostas) {
                          log(element.resposta.toString());
                        }
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ResultPage(
                              title: widget.nome,
                              length: widget.quantidadePerguntas,
                              result: 0,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
