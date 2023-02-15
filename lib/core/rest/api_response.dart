import 'dart:io';

import 'response_error.dart';
import 'response_status.dart';

class ApiResponse<T> {
  T? body;
  String? errorMessage;
  String? originalErrorMessage;
  int? responseCode = HttpStatus.internalServerError;
  int? errorCode;
  ResponseStatus status;
  ResponseError? errors;

  T get requiresBody {
    if (body != null) {
      return body!;
    } else {
      throw StateError('ApiResponse has neither data nor error');
    }
  }

  ApiResponse.loading() : status = ResponseStatus.loading;

  ApiResponse.initial(this.body) : status = ResponseStatus.initial;

  ApiResponse.success(this.body, {this.responseCode = HttpStatus.ok})
      : status = ResponseStatus.success;

  ApiResponse.disconnect()
      : status = ResponseStatus.disconnect,
        responseCode = HttpStatus.unauthorized;

  ApiResponse.error(this.responseCode, this.errorMessage,
      {this.errorCode, this.errors, this.originalErrorMessage})
      : status = ResponseStatus.error;

  ApiResponse.offline()
      : status = ResponseStatus.offline,
        errorMessage =
            "Não foi possível realizar a requisição. Parece que você não está conectado a internet.";

  ApiResponse.forcePrivacyPolicy()
      : status = ResponseStatus.privacyPolicy,
        responseCode = HttpStatus.forbidden,
        errorMessage = "";

  bool isSuccessResponse() => responseCode! >= 200 && responseCode! < 300;

  bool isInitial() => status == ResponseStatus.initial;

  bool isLoading() => status == ResponseStatus.loading;

  bool isError() => status == ResponseStatus.error;

  bool isOffline() => status == ResponseStatus.offline;

  bool isDisconnect() => status == ResponseStatus.disconnect;

  bool isPrivacyPolicy() => status == ResponseStatus.privacyPolicy;

  String noCodeErrorMessage() {
    final em = errorMessage;
    if (em == null || em.isEmpty) {
      return "";
    } else if (em.contains("- ")) {
      return em.split("- ")[1];
    }
    return em;
  }
}
