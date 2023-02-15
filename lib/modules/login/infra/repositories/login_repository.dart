import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:my_vocation_app/core/rest/api_error_handler.dart';
import 'package:my_vocation_app/core/rest/api_response.dart';
import 'package:my_vocation_app/core/rest/custom_dio.dart';
import 'package:my_vocation_app/modules/login/domain/models/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  final CustomDio dio;

  LoginRepository(this.dio);

  Future<ApiResponse<Usuario>> login(
      {required String user, required String password}) async {
    try {
      var response = await dio.post('/login', data: {
        'User': user,
        'Senha': password,
      });
      final accessToken = response.data['token'];

      if (accessToken == null) {
        return ApiResponse.error(401, "Token inválido.");
      }
      var result = Usuario.fromMap(response.data);
      final sp = await SharedPreferences.getInstance();
      sp.setString('accessToken', accessToken);
      sp.setString('username', result.nome);

      return ApiResponse<Usuario>.success(result);
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      return ApiErrorHandler.toApiResponse<Usuario>(e);
      // return ApiResponse.error(
      //     e.response?.statusCode, e.response?.statusMessage, errors: e.response?.data);
    }
  }

  Future<void> logout() {
    throw UnimplementedError();
  }
}
