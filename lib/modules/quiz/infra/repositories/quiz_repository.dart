import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:my_vocation_app/core/rest/api_error_handler.dart';
import 'package:my_vocation_app/core/rest/api_response.dart';
import 'package:my_vocation_app/core/rest/custom_dio.dart';
import 'package:my_vocation_app/modules/quiz/domain/models/pergunta.dart';
import 'package:my_vocation_app/modules/quiz/domain/models/usuario_questionario.dart';
import 'package:my_vocation_app/modules/quiz/infra/dtos/resposta_questionario_dto.dart';
import 'package:my_vocation_app/modules/result/domain/models/curso.dart';
import 'package:my_vocation_app/modules/result/infra/dtos/finish_quiz_dto.dart';

class QuizRepository {
  final CustomDio dio;

  QuizRepository(this.dio);

  Future<ApiResponse<List<Pergunta>>> getQuestions(
      {required int idQuestionario}) async {
    try {
      var response = await dio.auth().get('/pergunta/ListarPorQuestionario',
          queryParameters: {'idQuestionario': idQuestionario});

      var result =
          response.data.map<Pergunta>((g) => Pergunta.fromMap(g)).toList();

      return ApiResponse<List<Pergunta>>.success(result);
    } catch (e, s) {
      log('Erro ao buscar perguntas do questionário', error: e, stackTrace: s);
      return ApiErrorHandler.toApiResponse<List<Pergunta>>(e);
    }
  }

  Future<ApiResponse<UsuarioQuestionario>> startQuiz(
      {required int idUsuario, required int idQuestionario}) async {
    try {
      var response = await dio.auth().post('/questionario/iniciar',
          data: {'idUsuario': idUsuario, 'idQuestionario': idQuestionario});

      var result = UsuarioQuestionario.fromMap(response.data);

      return ApiResponse<UsuarioQuestionario>.success(result);
    } catch (e, s) {
      log('Erro ao iniciar questionário', error: e, stackTrace: s);
      return ApiErrorHandler.toApiResponse<UsuarioQuestionario>(e);
    }
  }

  Future<ApiResponse<List<Curso>>> finishQuiz({
    required int idUsuario,
    required int idQuestionario,
    required List<RespostaQuestionarioDto> respostas,
  }) async {
    try {
      dynamic result;

      for (int i = 0; i < respostas.length; i++) {
        FinishQuizDto dto = FinishQuizDto(
          idUsuario: idUsuario,
          idQuestionario: idQuestionario,
          idPergunta: respostas[i].idPergunta,
          resposta: respostas[i].resposta,
          perguntaFinal: respostas.length == i,
        );
        var response = await dio.auth().post('/questionario/finalizar', data: {
          'IdUsuario': idUsuario,
          'IdQuestionario': idQuestionario,
          'IdPergunta': respostas[i].idPergunta,
          'Resposta': respostas[i].resposta,
          'PerguntaFinal': respostas.length == (i + 1),
        });

        result = response.data.map<Curso>((g) => Curso.fromMap(g)).toList();
      }

      return ApiResponse<List<Curso>>.success(result);
    } catch (e, s) {
      log('Erro ao finalizar questionário', error: e, stackTrace: s);
      return ApiErrorHandler.toApiResponse<List<Curso>>(e);
    }
  }
}
