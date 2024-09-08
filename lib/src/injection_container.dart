import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/data/http_helper.dart';
import 'core/data/network_info.dart';
import 'core/data/prefs_helper.dart';
import 'core/navigation/app_router.dart';
import 'core/utils/global_config.dart';
import 'core/utils/location_service.dart';
import 'features/assignments/data/dataSources/assignment_data_source.dart';
import 'features/assignments/data/repositories/assignment_repository_impl.dart';
import 'features/assignments/domain/repositories/assignment_repository.dart';
import 'features/assignments/presentation/bloc/assignment_bloc.dart';
import 'features/auth/data/dataSources/authentication_data_source.dart';
import 'features/auth/data/repositories/authentication_repository_impl.dart';
import 'features/auth/domain/repositories/authentication_repository.dart';
import 'features/auth/presentation/screens/login/bloc/bloc.dart';
import 'features/tracking/data/dataSources/tracking_data_source.dart';
import 'features/tracking/data/repositories/tracking_repository_impl.dart';
import 'features/tracking/domain/repositories/tracking_repository.dart';
import 'features/tracking/presentation/bloc/bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton(Dio(
    BaseOptions(
      connectTimeout: const Duration(milliseconds: 180000),
      receiveTimeout: const Duration(milliseconds: 180000),
      responseType: ResponseType.plain,
      receiveDataWhenStatusError: true,
      headers: {
        'accept': 'application/json',
        'content-type': 'application/json'
      },
    ),
  ));

  getIt.registerSingleton<AppRouter>(AppRouter());

  getIt.registerLazySingleton<HttpHelper>(
    () => HttpHelper(getIt<Dio>(), getIt<PrefsHelper>()),
  );

  getIt.registerLazySingleton<PrefsHelper>(
    () => PrefsHelper(),
  );

  getIt.registerFactory<GlobalConfig>(
    () => GlobalConfig(),
  );

  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  getIt.registerLazySingleton<LocationService>(() => LocationService());

  /// Repositories
  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthenticationDataSourceImpl>(),
      getIt<PrefsHelper>(),
    ),
  );

  getIt.registerLazySingleton<AssignmentRepository>(
    () => AssignmentRepositoryImpl(
      getIt<AssignmentDataSourceImpl>(),
    ),
  );

  getIt.registerLazySingleton<TrackingRepository>(
    () => TrackingRepositoryImpl(
      getIt<TrackingDataSourceImpl>(),
    ),
  );

  /// Data Sources
  getIt.registerLazySingleton<AuthenticationDataSourceImpl>(
    () => AuthenticationDataSourceImpl(
      getIt<HttpHelper>(),
    ),
  );

  getIt.registerLazySingleton<AssignmentDataSourceImpl>(
    () => AssignmentDataSourceImpl(
      getIt<HttpHelper>(),
    ),
  );

  getIt.registerLazySingleton<TrackingDataSourceImpl>(
    () => TrackingDataSourceImpl(
      getIt<HttpHelper>(),
    ),
  );

  /// Bloc
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(),
  );

  getIt.registerFactory<AssignmentBloc>(
    () => AssignmentBloc(),
  );

  getIt.registerFactory<TrackingBloc>(
    () => TrackingBloc(),
  );
}
