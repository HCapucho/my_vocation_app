import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_vocation_app/core/core.dart';
import 'package:my_vocation_app/core/helpers/loader.dart';
import 'package:my_vocation_app/core/helpers/messages.dart';
import 'package:my_vocation_app/modules/home/domain/bloc/home_bloc.dart';
import 'package:my_vocation_app/modules/home/widgets/appbar/app_bar_widget.dart';
import 'package:my_vocation_app/modules/home/widgets/quiz_card/quiz_card_widget.dart';
import 'package:my_vocation_app/modules/login/domain/models/usuario.dart';
import 'package:my_vocation_app/modules/quiz/quiz_page.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with Messages<HomePage>, Loader<HomePage> {
  late final HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<HomeBloc>();
    _getQuizzes();
  }

  void _getQuizzes() {
    bloc.add(GetQuizzesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(username: widget.username),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is GetQuizzesInProgress) {
            showLoader();
          }
          if (state is GetQuizzesFailure) {
            hideLoader();
            showError(state.errorMessage);
          }
          if (state is GetQuizzesSuccess) {
            hideLoader();
          }
        },
        builder: (context, state) {
          if (state is GetQuizzesInProgress) {
            return Container();
          }
          if (state is GetQuizzesFailure) {
            return Container();
          }
          if (state is GetQuizzesSuccess) {
            return Padding(
              padding: const EdgeInsets.all(19),
              child: Column(
                children: [
                  Text(
                    "Questionários",
                    style: AppTextStyles.heading30,
                  ),
                  SizedBox(height: 24),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: state.quizzes
                          .map((e) => QuizCardWidget(
                                title: e.nome,
                                numberOfQuestions: e.quantidadePerguntas,
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => QuizPage(
                                      idQuestionario: e.id,
                                      quantidadePerguntas: e.quantidadePerguntas,
                                      nome: e.nome,
                                    ),
                                  ));
                                },
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
