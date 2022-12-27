import 'package:get_it/get_it.dart' show GetIt;
import 'package:dio/dio.dart' show Dio;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    show InternetConnectionChecker;
import 'package:price_tracker/core/services/web_socket_service.dart';
import '../services/network_connection.dart';
import '../services/web_service.dart';


/// sl -> Service Locator
final sl = GetIt.instance;

void initialize() {

  //! Core
  sl.registerLazySingleton(() => WebService(dio: sl()));
  sl.registerLazySingleton(() => WebSocketService());
  sl.registerLazySingleton<NetworkConnection>(
        () => NetworkConnectionImplementation(sl()),
  );

  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}