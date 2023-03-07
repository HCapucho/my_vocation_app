part of 'result_bloc.dart';

@immutable
abstract class ResultEvent {}

class FinishQuizEvent extends ResultEvent {
  final int idUsuario;
  final int idQuestionario;
  final List<RespostaQuestionarioDto> respostas;

  FinishQuizEvent(
      {required this.idUsuario,
      required this.idQuestionario,
      required this.respostas});
}
