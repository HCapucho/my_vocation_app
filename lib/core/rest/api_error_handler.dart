import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:my_vocation_app/core/extensions/string_exstension.dart';
import 'package:my_vocation_app/core/utils/logger.dart';

import 'api_response.dart';
import 'error_message.dart';
import 'response_error.dart';

class ApiErrorHandler {
  static ApiResponse<T> toApiResponse<T>(Object ob) {
    if (ob is! DioError) {
      if (ob is http.Response) {
        return _httpError(ob);
      }
      return _internalServerError<T>();
    }

    DioError error = ob;

    switch (error.type) {
      case DioErrorType.other:
        return ApiResponse<T>.offline();
      case DioErrorType.response:
        return _handleApiError<T>(error);
      default:
        return _internalServerError<T>();
    }
  }

  static ApiResponse<T> _httpError<T>(http.Response response) {
    switch (response.statusCode) {
      case HttpStatus.internalServerError:
        return _internalServerError();
      case HttpStatus.unauthorized:
        return ApiResponse<T>.disconnect();
      case HttpStatus.forbidden:
        return ApiResponse<T>.forcePrivacyPolicy();
      default:
        {
          String message = "";

          try {
            ResponseError? restError;
            late int errorCode;
            try {
              var decode = jsonDecode(response.body);
              restError = ResponseError.fromJson(decode);
              if (restError.errors.isNotEmpty) {
                message = restError.errors[0];
              }
              errorCode = restError.code;
            } catch (exc) {
              var decode = jsonDecode(response.body);
              final messageError = ErrorMessage.fromJson(decode);
              message = messageError.message;
            }

            //Centraliza erro 500 para evitar replicação igual no android
            //Passar a mensagem de erro original para tratativas específicas
            if (response.statusCode == HttpStatus.internalServerError) {
              return _internalServerError(
                  code: response.statusCode, originalErrorMessage: message);
            }

            return ApiResponse<T>.error(response.statusCode, message,
                errorCode: errorCode,
                errors: restError,
                originalErrorMessage: message);
          } catch (e) {
            Logger.erro(e);
            return _internalServerError<T>();
          }
        }
    }
  }

  static ApiResponse<T> _internalServerError<T>({
    int code = HttpStatus.internalServerError,
    String originalErrorMessage = "",
  }) {
    return ApiResponse<T>.error(
      code,
      "Ocorreu um erro inesperado. Caso o problema persista, entre em contato.",
      originalErrorMessage: originalErrorMessage,
    );
  }

  static ApiResponse<T> _handleApiError<T>(DioError error) {
    String message = "";

    try {
      if (error.response?.statusCode == HttpStatus.unauthorized) {
        return ApiResponse<T>.disconnect();
      }

      if (error.response?.statusCode == HttpStatus.forbidden) {
        return ApiResponse<T>.forcePrivacyPolicy();
      }

      ResponseError? restError;
      late int errorCode;
      try {
        var decode = error.response?.data is String
            ? jsonDecode(error.response?.data)
            : error.response?.data;
        restError = ResponseError.fromMap(decode);
        if (restError.errors.isNotEmpty) {
          message = restError.errors[0];
        }
        errorCode = restError.code;
      } catch (exc) {
        var decode = error.response?.data is String
            ? jsonDecode(error.response?.data)
            : error.response?.data;
        var messageError = ErrorMessage.fromMap(decode);
        message = messageError.message;
      }

      //Centraliza erro 500 para evitar replicação igual no android
      //Passar a mensagem de erro original para tratativas específicas
      if (error.response?.statusCode == HttpStatus.internalServerError) {
        return _internalServerError(
            code: error.response?.statusCode ?? 500,
            originalErrorMessage: message);
      }

      return ApiResponse<T>.error(
        error.response?.statusCode ?? 400,
        message,
        errorCode: errorCode,
        errors: restError,
        originalErrorMessage: message,
      );
    } catch (e) {
      Logger.erro(e);
      return _internalServerError<T>();
    }
  }
}
