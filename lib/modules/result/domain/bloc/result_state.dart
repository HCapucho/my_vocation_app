part of 'result_bloc.dart';

@immutable
abstract class ResultState {}

class ResultInitial extends ResultState {}

// Finish Quiz
class FinishQuizInProgress extends ResultState {}

class FinishQuizFailure extends ResultState {
  final String errorMessage;

  FinishQuizFailure(this.errorMessage);
}

class FinishQuizSuccess extends ResultState {
  final List<Curso> cursos;
  FinishQuizSuccess(this.cursos);
}
