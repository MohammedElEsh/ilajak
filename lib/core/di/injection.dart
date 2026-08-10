import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
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
import 'package:ilajak/features/auth/presentation/manager/auth_change_password_cubit.dart';
import 'package:ilajak/features/auth/presentation/manager/auth_login_cubit.dart';
import 'package:ilajak/features/auth/presentation/manager/doctor_register_cubit.dart';
import 'package:ilajak/features/doctor/medical_records/data/repositories/medical_records_repository_impl.dart';
import 'package:ilajak/features/doctor/medical_records/domain/repositories/medical_records_repository.dart';
import 'package:ilajak/features/doctor/medical_records/logic/doctor_medical_records_cubit/doctor_medical_records_cubit.dart';
import 'package:ilajak/features/doctor/prescriptions/data/repositories/doctor_prescriptions_repository_impl.dart';
import 'package:ilajak/features/doctor/prescriptions/domain/repositories/doctor_prescriptions_repository.dart';
import 'package:ilajak/features/doctor/prescriptions/logic/doctor_prescriptions_cubit/doctor_prescriptions_cubit.dart';
import 'package:ilajak/features/doctor/profile/data/repositories/doctor_profile_repository.dart';
import 'package:ilajak/features/doctor/profile/data/repositories/doctor_profile_repository_impl.dart';
import 'package:ilajak/features/doctor/profile/presentation/manager/doctor_profile_cubit.dart';
import 'package:ilajak/features/doctor/schedule/domain/repositories/appointments_repository.dart';
import 'package:ilajak/features/doctor/schedule/data/repositories/appointments_repository_impl.dart';
import 'package:ilajak/features/doctor/schedule/logic/doctor_schedule_cubit/doctor_schedule_cubit.dart';
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

  sl.registerFactory<DoctorRegisterCubit>(
    () => DoctorRegisterCubit(sl<AuthRepository>()),
  );

  // Generic (not doctor-specific) — PUT /user/change-password is the same
  // endpoint for patient and doctor accounts. Reuse this same registration
  // for patient_change_password_view.dart whenever that screen is wired.
  sl.registerFactory<AuthChangePasswordCubit>(
    () => AuthChangePasswordCubit(sl<AuthRepository>()),
  );

  // =====================================================
  // 9. FEATURE: DOCTOR PROFILE
  // =====================================================
  sl.registerLazySingleton<DoctorProfileRepository>(
    () => DoctorProfileRepositoryImpl(apiConsumer: sl<ApiConsumer>()),
  );

  sl.registerFactory<DoctorProfileCubit>(
    () => DoctorProfileCubit(
      sl<DoctorProfileRepository>(),
      sl<AuthRepository>(),
      sl<MediaService>(),
    ),
  );

  // =====================================================
  // 10. FEATURE: DOCTOR SCHEDULE
  // =====================================================
  sl.registerLazySingleton<AppointmentsRepository>(
    () => AppointmentsRepositoryImpl(apiConsumer: sl<ApiConsumer>()),
  );

  sl.registerFactory<DoctorScheduleCubit>(
    () => DoctorScheduleCubit(sl<AppointmentsRepository>()),
  );

  // =====================================================
  // 11. FEATURE: DOCTOR MEDICAL RECORDS
  // =====================================================
  sl.registerLazySingleton<MedicalRecordsRepository>(
    () => MedicalRecordsRepositoryImpl(apiConsumer: sl<ApiConsumer>()),
  );

  sl.registerFactory<DoctorMedicalRecordsCubit>(
    () => DoctorMedicalRecordsCubit(sl<MedicalRecordsRepository>()),
  );

  // =====================================================
  // 12. FEATURE: DOCTOR PRESCRIPTIONS
  // =====================================================
  sl.registerLazySingleton<DoctorPrescriptionsRepository>(
    () => DoctorPrescriptionsRepositoryImpl(apiConsumer: sl<ApiConsumer>()),
  );

  sl.registerFactory<DoctorPrescriptionsCubit>(
    () => DoctorPrescriptionsCubit(sl<DoctorPrescriptionsRepository>()),
  );
}
