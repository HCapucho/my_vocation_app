import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_vocation_app/modules/home/domain/models/questionario.dart';
import 'package:my_vocation_app/modules/home/infra/repositories/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<GetQuizzesEvent>(_getQuizzes);
  }

  FutureOr<void> _getQuizzes(
      GetQuizzesEvent event, Emitter<HomeState> emit) async {
    emit(GetQuizzesInProgress());
    final response =
        await homeRepository.getQuizzes();

    if (response.isError()) {
      emit(GetQuizzesFailure(response.errorMessage!));
    } else if (response.isSuccessResponse()) {
      emit(GetQuizzesSuccess(response.requiresBody));
    }
  }
}
