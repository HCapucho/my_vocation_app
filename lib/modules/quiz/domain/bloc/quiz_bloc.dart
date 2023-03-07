import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_vocation_app/modules/quiz/domain/models/pergunta.dart';
import 'package:my_vocation_app/modules/quiz/domain/models/usuario_questionario.dart';
import 'package:my_vocation_app/modules/quiz/infra/dtos/resposta_questionario_dto.dart';
import 'package:my_vocation_app/modules/quiz/infra/repositories/quiz_repository.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository quizRepository;
  QuizBloc(this.quizRepository) : super(QuizInitial()) {
    on<GetQuestionsEvent>(_getQuestions);
    on<StartQuizEvent>(_startQuiz);
  }

  FutureOr<void> _getQuestions(
      GetQuestionsEvent event, Emitter<QuizState> emit) async {
    emit(GetQuestionsInProgress());
    final response =
        await quizRepository.getQuestions(idQuestionario: event.idQuestionario);

    if (response.isError()) {
      emit(GetQuestionsFailure(response.errorMessage!));
    } else if (response.isSuccessResponse()) {
      emit(GetQuestionsSuccess(response.requiresBody));
    }
  }

  FutureOr<void> _startQuiz(
      StartQuizEvent event, Emitter<QuizState> emit) async {
    emit(StartQuizInProgress());
    final response = await quizRepository.startQuiz(
      idUsuario: event.idUsuario,
      idQuestionario: event.idQuestionario,
    );

    if (response.isError()) {
      emit(StartQuizFailure(response.errorMessage!));
    } else if (response.isSuccessResponse()) {
      emit(StartQuizSuccess(response.requiresBody));
    }
  }
}
