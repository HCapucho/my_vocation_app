import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:my_vocation_app/core/rest/api_error_handler.dart';
import 'package:my_vocation_app/core/rest/api_response.dart';
import 'package:my_vocation_app/core/rest/custom_dio.dart';
import 'package:my_vocation_app/modules/quiz/domain/models/pergunta.dart';
import 'package:my_vocation_app/modules/quiz/domain/models/usuario_questionario.dart';
import 'package:my_vocation_app/modules/quiz/infra/dtos/resposta_questionario_dto.dart';

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

  Future<ApiResponse<UsuarioQuestionario>> finishQuiz(
      {required int idUsuario,
      required int idQuestionario,
      required List<RespostaQuestionarioDto> respostas}) async {
    try {
      var response = await dio.auth().post('/questionario/finalizar', data: {
        'idUsuario': idUsuario,
        'idQuestionario': idQuestionario,
        'respostas': respostas
      });

      var result = UsuarioQuestionario.fromMap(response.data);

      return ApiResponse<UsuarioQuestionario>.success(result);
    } catch (e, s) {
      log('Erro ao finalizar questionário', error: e, stackTrace: s);
      return ApiErrorHandler.toApiResponse<UsuarioQuestionario>(e);
    }
  }
}
