import 'package:dio/dio.dart';
import 'package:price_tracker/core/enums/log.dart';

import '../errors/exceptions.dart';
import '../utils/api_url.dart';
import 'network_connection.dart';
import '../dependency_injection/service_locator.dart';

// Please using any technique to create singleton WebService (GetIt)
class WebService {
  final Dio dio;

  WebService({required this.dio}) {
    dio.options.baseUrl = ApiUrl.baseUrl;
    dio.options.connectTimeout = 100000;
    dio.options.receiveTimeout = 100000;
    dio.options.sendTimeout = 100000;
    dio.interceptors.add(AppInterceptors());
  }
}

class AppInterceptors extends Interceptor {
  late NetworkConnection networkConnection;

  AppInterceptors() {
    networkConnection = sl<NetworkConnection>();
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {

    if (await networkConnection.isConnected == false) {
      "Request-Rejected because 'Network-Disconnected'".errorLog();
      return handler.reject(NoInternetConnectionException(options));
    }
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    "Opps, recieved Error: ${err.response?.statusCode}".errorLog();

    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions, err.response);
          case 401:
            throw UnInvalidCredentialsException(
              err.requestOptions,
              err.response,
            );
          case 403:
            throw UnAuthorizedException(err.requestOptions, err.response);
          case 404:
            throw RequestNotFoundException(err.requestOptions, err.response);
          case 405:
            throw MethodNotAllowedException(err.requestOptions, err.response);
          case 409:
            throw ConflictException(err.requestOptions, err.response);
          case 417:
            throw ExpectationFailed(err.requestOptions, err.response);
          case 500:
            throw InternalServerErrorException(
              err.requestOptions,
              err.response,
            );
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        "Other Error received: ${err.error}".errorLog();
        throw ServerException(err.message);
    }

    return handler.next(err);
  }
}
