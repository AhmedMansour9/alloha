import 'package:alloha/provider/auth_provider.dart';
import 'package:alloha/provider/localization_provider.dart';
import 'package:alloha/util/app_constants.dart';
import 'package:alloha/view/screens/splash/splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/remote/dio/dia_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/repositry/auth_rebo.dart';


final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));


  // Repository
  sl.registerLazySingleton(() => AuthRepo(dioClient: sl(), sharedPreferences: sl()));


  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));


  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
