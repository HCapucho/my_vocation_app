part of 'quiz_bloc.dart';

@immutable
abstract class QuizEvent {}

class GetQuestionsEvent extends QuizEvent {
  final int idQuestionario;
  GetQuestionsEvent(this.idQuestionario);
}

class StartQuizEvent extends QuizEvent {
  final int idUsuario;
  final int idQuestionario;

  StartQuizEvent(this.idUsuario, this.idQuestionario);
}

class FinishQuizEvent extends QuizEvent {
  final int idUsuario;
  final int idQuestionario;
  final List<RespostaQuestionarioDto> respostas;

  FinishQuizEvent(this.idUsuario, this.idQuestionario, this.respostas);
}
