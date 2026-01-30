// lib/core/di/injection_container.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/dio_consumer.dart';

final sl = GetIt.instance;
void init() {
  // External - Dio
  sl.registerLazySingleton<Dio>(() => Dio());

  // API Consumer
  sl.registerLazySingleton<DioConsumer>(() => DioConsumer(dio: sl<Dio>()));

  // Repository
  // sl.registerLazySingleton<AuthClientRepository>(
  //   () => AuthClientRepository(api: sl<DioConsumer>()),
  // );

  sl.registerLazySingleton<CacheHelper>(() => CacheHelper());

  // Cubit
  // sl.registerFactory<ClientCubit>(
  //   () => ClientCubit(
  //     signupRepository: sl<AuthClientRepository>(),
  //     cacheHelper: sl<CacheHelper>(),
  //   ),
  // );
}
