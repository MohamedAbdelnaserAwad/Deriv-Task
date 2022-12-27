import 'package:dio/dio.dart';
import 'package:price_tracker/core/extensions/api_responses_conversion.dart';

import '../enums/api_responses.dart';

// Global Exceptions
class ServerException implements Exception {
  final String errorMessage;
  final int? statusCode;
  final String? statusMessage;

  const ServerException(
      this.errorMessage, {
        this.statusCode,
        this.statusMessage,
      });

  @override
  String toString() =>
      'ServerException(errorMessage: $errorMessage, statusCode: $statusCode, statusMessage: $statusMessage)';
}

class AuthNotFoundedException implements Exception {}

class OnBoardingNotVisitedException implements Exception {}

class StepsNotMatchingStepsNamesException implements Exception {}

/* ------------ Web Services Exceptions ------------ */
class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions requestOptions)
      : super(requestOptions: requestOptions);

  @override
  String toString() => ApiResponse.deadlineExceeded.getErrorMessage(response);
}

//! Tokens Exceptions
class TokenNotFoundException extends DioError {
  TokenNotFoundException(RequestOptions requestOptions)
      : super(requestOptions: requestOptions);

  @override
  String toString() => ApiResponse.tokenNotFound.getErrorMessage(response);
}

class BadRequestException extends DioError {
  BadRequestException(
    RequestOptions requestOptions,
    Response? response,
  ) : super(requestOptions: requestOptions, response: response);

  @override
  String toString() => ApiResponse.badRequest.getErrorMessage(response);
}

class UnInvalidCredentialsException extends DioError {
  UnInvalidCredentialsException(
    RequestOptions requestOptions,
    Response? response,
  ) : super(requestOptions: requestOptions, response: response);

  @override
  String toString() => ApiResponse.invalidCredentials.getErrorMessage(response);
}

class UnAuthorizedException extends DioError {
  UnAuthorizedException(
    RequestOptions requestOptions,
    Response? response,
  ) : super(requestOptions: requestOptions, response: response);

  @override
  String toString() => ApiResponse.unAuthorized.getErrorMessage(response);
}

class RequestNotFoundException extends DioError {
  RequestNotFoundException(
    RequestOptions requestOptions,
    Response? response,
  ) : super(requestOptions: requestOptions, response: response);

  @override
  String toString() => ApiResponse.requestNotFound.getErrorMessage(response);
}

class MethodNotAllowedException extends DioError {
  MethodNotAllowedException(
    RequestOptions requestOptions,
    Response? response,
  ) : super(requestOptions: requestOptions, response: response);

  @override
  String toString() => ApiResponse.methodNotAllowed.getErrorMessage(response);
}

class ConflictException extends DioError {
  ConflictException(
    RequestOptions requestOptions,
    Response? response,
  ) : super(requestOptions: requestOptions, response: response);

  @override
  String toString() => ApiResponse.conflict.getErrorMessage(response);
}

class ExpectationFailed extends DioError {
  ExpectationFailed(
    RequestOptions requestOptions,
    Response? response,
  ) : super(requestOptions: requestOptions, response: response);

  @override
  String toString() => ApiResponse.expectationFailed.getErrorMessage(response);
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(
    RequestOptions requestOptions,
    Response? response,
  ) : super(requestOptions: requestOptions, response: response);

  @override
  String toString() =>
      ApiResponse.internalServerError.getErrorMessage(response);
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions requestOptions)
      : super(requestOptions: requestOptions);

  @override
  String toString() =>
      ApiResponse.noInternetConnection.getErrorMessage(response);
}
