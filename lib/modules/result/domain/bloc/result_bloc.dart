import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_vocation_app/modules/quiz/domain/bloc/quiz_bloc.dart';
import 'package:my_vocation_app/modules/quiz/infra/dtos/resposta_questionario_dto.dart';
import 'package:my_vocation_app/modules/quiz/infra/repositories/quiz_repository.dart';
import 'package:my_vocation_app/modules/result/domain/models/curso.dart';

part 'result_event.dart';
part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final QuizRepository quizRepository;
  ResultBloc(this.quizRepository) : super(ResultInitial()) {
    on<FinishQuizEvent>(_finishQuiz);
  }

  FutureOr<void> _finishQuiz(
      FinishQuizEvent event, Emitter<ResultState> emit) async {
    emit(FinishQuizInProgress());
    final response = await quizRepository.finishQuiz(
      idUsuario: event.idUsuario,
      idQuestionario: event.idQuestionario,
      respostas: event.respostas,
    );

    if (response.isError()) {
      emit(FinishQuizFailure(response.errorMessage!));
    } else if (response.isSuccessResponse()) {
      emit(FinishQuizSuccess(response.requiresBody));
    }
  }
}
