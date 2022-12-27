
import '../enums/api_responses.dart';
import 'package:dio/dio.dart';
typedef ResponseDataInMapFormat = Map<String, dynamic>;

extension APIResponsesConversion on ApiResponse {
  String getErrorMessage([Response? response]) {
    final serverErrorMessage = _handleServerErrorMessage(response);
    switch (this) {
      case ApiResponse.deadlineExceeded:
        return "errorConnectionTimeoutWord";
      case ApiResponse.badRequest:
        return serverErrorMessage ?? "errorBadRequestWord";
      case ApiResponse.invalidCredentials:
        return serverErrorMessage ?? "errorInvalidCredentialsWord";
      case ApiResponse.unAuthorized:
        return serverErrorMessage ?? "errorUnAuthorizedUserWord";
      case ApiResponse.requestNotFound:
        return serverErrorMessage ?? "errorRequestNotFoundWord";
      case ApiResponse.methodNotAllowed:
        return serverErrorMessage ?? "errorMethodNotAllowedWord";
      case ApiResponse.conflict:
        return serverErrorMessage ?? "errorConflictWord";
      case ApiResponse.expectationFailed:
        return serverErrorMessage ?? "validationError";
      case ApiResponse.internalServerError:
        return "errorInternalServerErrorWord";
      case ApiResponse.noInternetConnection:
        return "errorNoInternetConnectionWord";
      case ApiResponse.tokenNotFound:
        return "tokenNotFound";
    }
  }

  String? _handleServerErrorMessage(Response? response) {
    String? message;
    if (response != null &&
        response.data != null &&
        response.data is ResponseDataInMapFormat) {
      message = _checkErrorMessage(response.data);
    }
    return message;
  }

  String? _checkErrorMessage(ResponseDataInMapFormat response) {
    String? message;
    if (response["message"] != null && response["message"].isNotEmpty) {
      message = response['message'];
    }
    return message;
  }
}
