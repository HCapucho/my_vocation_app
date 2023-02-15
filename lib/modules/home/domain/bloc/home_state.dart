part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetQuizzesInProgress extends HomeState {}

class GetQuizzesFailure extends HomeState {
  final String errorMessage;

  GetQuizzesFailure(this.errorMessage);
}

class GetQuizzesSuccess extends HomeState {
  final List<Questionario> quizzes;

  GetQuizzesSuccess(this.quizzes);
}
