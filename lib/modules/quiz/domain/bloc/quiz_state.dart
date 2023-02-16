part of 'quiz_bloc.dart';

@immutable
abstract class QuizState {}

class QuizInitial extends QuizState {}

// Get Questions
class GetQuestionsInProgress extends QuizState {}

class GetQuestionsFailure extends QuizState {
  final String errorMessage;

  GetQuestionsFailure(this.errorMessage);
}

class GetQuestionsSuccess extends QuizState {
  final List<Pergunta> questions;

  GetQuestionsSuccess(this.questions);
}

// Start Quiz
class StartQuizInProgress extends QuizState {}

class StartQuizFailure extends QuizState {
  final String errorMessage;

  StartQuizFailure(this.errorMessage);
}

class StartQuizSuccess extends QuizState {
  final UsuarioQuestionario usuarioQuestionario;
  StartQuizSuccess(this.usuarioQuestionario);
}

// Finish Quiz
class FinishQuizInProgress extends QuizState {}

class FinishQuizFailure extends QuizState {
  final String errorMessage;

  FinishQuizFailure(this.errorMessage);
}

class FinishQuizSuccess extends QuizState {
  final UsuarioQuestionario usuarioQuestionario;
  FinishQuizSuccess(this.usuarioQuestionario);
}
