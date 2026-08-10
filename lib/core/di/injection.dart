import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ilajak/features/patient/appointments/data/repos/doctors_repo.dart';
import 'package:ilajak/features/patient/appointments/data/repos/doctors_repo_implementation.dart';
import 'package:ilajak/features/patient/profile/data/repos/profile_repo.dart';
import 'package:ilajak/features/patient/profile/data/repos/profile_repo_impl.dart';
import 'package:ilajak/features/patient/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ilajak/core/networking/api_consumer.dart';
import 'package:ilajak/core/networking/api_interceptors.dart';
import 'package:ilajak/core/networking/dio_consumer.dart';
import 'package:ilajak/core/services/auth/token_refresher.dart';
import 'package:ilajak/core/services/auth/token_service.dart';
import 'package:ilajak/core/services/connectivity/connectivity_service.dart';
import 'package:ilajak/core/services/media/media_service.dart';
import 'package:ilajak/core/services/session/session_manager.dart';
import 'package:ilajak/core/services/storage/secure_storage_service.dart';
import 'package:ilajak/features/auth/data/repositories/auth_repository.dart';
import 'package:ilajak/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ilajak/features/auth/presentation/manager/auth_login_cubit.dart';
import 'package:ilajak/features/auth/presentation/manager/auth_register_cubit.dart';
import 'package:ilajak/features/onboarding/presentation/manager/onboarding_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // =====================================================
  // 1. STORAGE LAYER
  // =====================================================
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  sl.registerLazySingleton<SecureStorageService>(
    () => SecureStorageServiceImpl(),
  );

  // =====================================================
  // 2. TOKEN SERVICE
  // =====================================================
  sl.registerLazySingleton<TokenService>(
    () => TokenService(secureStorage: sl<SecureStorageService>()),
  );

  // =====================================================
  // 3. TOKEN REFRESHER
  // =====================================================
  sl.registerLazySingleton<TokenRefresher>(
    () => TokenRefresher(tokenService: sl<TokenService>()),
  );

  // =====================================================
  // 4. SESSION
  // =====================================================
  sl.registerLazySingleton<SessionManager>(
    () => SessionManager(
      sl<SharedPreferences>(),
      sl<TokenService>(),
      sl<TokenRefresher>(),
    ),
  );

  // =====================================================
  // 5. NETWORK LAYER
  // =====================================================
  sl.registerLazySingleton<Dio>(() {
    return Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );
  });

  sl.registerLazySingleton<ApiInterceptors>(
    () => ApiInterceptors(
      dio: sl<Dio>(),
      tokenService: sl<TokenService>(),
      tokenRefresher: sl<TokenRefresher>(),
      sessionManager: sl<SessionManager>(),
      connectivityService: sl<ConnectivityService>(),
    ),
  );

  sl.registerLazySingleton<DioConsumer>(
    () => DioConsumer(
      sl<Dio>(),
      apiInterceptors: sl<ApiInterceptors>(),
    ),
  );

  sl.registerLazySingleton<ApiConsumer>(
    () => sl<DioConsumer>(),
  );
  sl.registerLazySingleton<DoctorsRepo>(
    () => DoctorsRepoImplementation(sl<ApiConsumer>()),
  );
  // =====================================================
  // 6. CORE SERVICES
  // =====================================================
  sl.registerLazySingleton<Connectivity>(
    () => Connectivity(),
  );

  sl.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(sl()),
  );

  sl.registerLazySingleton<MediaService>(
    () => MediaServiceImpl(),
  );

  // =====================================================
  // 7. FEATURE: ONBOARDING
  // =====================================================
  sl.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(sl()),
  );

  // =====================================================
  // 8. FEATURE: AUTH
  // =====================================================
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      apiConsumer: sl<ApiConsumer>(),
      sessionManager: sl<SessionManager>(),
    ),
  );

  sl.registerFactory<AuthLoginCubit>(
    () => AuthLoginCubit(sl<AuthRepository>()),
  );
  // =====================================================
  // 9. FEATURE: PROFILE
  // =====================================================
  sl.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(
      apiConsumer: sl<ApiConsumer>(),
      sessionManager: sl<SessionManager>(),
    ),
  );
  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(sl<ProfileRepo>()),
  );

  sl.registerFactory<AuthRegisterCubit>(
    () => AuthRegisterCubit(sl<AuthRepository>()),
  );
}
