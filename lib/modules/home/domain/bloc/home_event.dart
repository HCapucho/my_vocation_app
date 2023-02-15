part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetQuizzesEvent extends HomeEvent {
  GetQuizzesEvent();
}
