import 'dart:developer';
import 'package:my_vocation_app/core/rest/api_error_handler.dart';
import 'package:my_vocation_app/core/rest/api_response.dart';
import 'package:my_vocation_app/core/rest/custom_dio.dart';

import 'package:my_vocation_app/modules/home/domain/models/questionario.dart';

class HomeRepository {
  final CustomDio dio;

  HomeRepository(this.dio);

  Future<ApiResponse<List<Questionario>>> getQuizzes() async {
    try {
      var response = await dio.auth().get('/questionario');

      var result = response.data
          .map<Questionario>((g) => Questionario.fromMap(g))
          .toList();

      return ApiResponse<List<Questionario>>.success(result);
    } catch (e, s) {
      log('Erro ao buscar questionários', error: e, stackTrace: s);
      return ApiErrorHandler.toApiResponse<List<Questionario>>(e);
    }
  }
}
