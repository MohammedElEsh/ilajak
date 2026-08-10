import 'package:ilajak/core/errors/failures.dart';
import 'package:ilajak/core/errors/safe_call.dart';
import 'package:ilajak/core/networking/api_consumer.dart';
import 'package:ilajak/core/networking/api_endpoints.dart';
import 'package:ilajak/core/services/session/session_manager.dart';
import 'package:ilajak/core/services/logger/logger_service.dart';

import '../models/auth_tokens.dart';
import '../models/user_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiConsumer _apiConsumer;
  final SessionManager _sessionManager;

  AuthRepositoryImpl({
    required ApiConsumer apiConsumer,
    required SessionManager sessionManager,
  }) : _apiConsumer = apiConsumer,
       _sessionManager = sessionManager;

  @override
  EitherResult<AuthTokens> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) {
    return safeCall(() async {
      final response = await _apiConsumer.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      if (response is! Map<String, dynamic>) {
        throw const ServerFailure('Unexpected response format');
      }

      // See AuthTokens.fromJson for why we check both keys.
      final accessToken = (response['access_token'] ?? response['token']) as String?;
      if (accessToken == null || accessToken.isEmpty) {
        final message = response['message'] as String?;
        throw ServerFailure(message ?? 'Incorrect email or password');
      }

      final tokens = AuthTokens.fromJson(response);

      final user = response['user'] is Map<String, dynamic>
          ? UserModel.fromJson(response['user'] as Map<String, dynamic>)
          : null;

      if (user != null) {
        await _sessionManager.saveUserData(user);
      }

      if (user?.role != null) {
        final role = UserRole.values.firstWhere(
          (r) => r.name == user!.role,
          orElse: () {
            LoggerService.w('⚠️ [AuthRepository.login] API role mismatch: "${user!.role}". Keeping client-selected role: ${_sessionManager.role.name}', tag: 'AuthRepository');
            return _sessionManager.role;  // Keep the client-selected role
          },
        );
        LoggerService.d('🔐 [AuthRepository.login] Updating role from API: ${user!.role} → ${role.name}', tag: 'AuthRepository');
        _sessionManager.setRole(role);
      } else {
        LoggerService.w('⚠️ [AuthRepository.login] No role in API response, keeping client-selected role: ${_sessionManager.role.name}', tag: 'AuthRepository');
      }

      await _sessionManager.login(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
        skipSetup: true,
        persist: rememberMe,
      );

      return tokens;
    });
  }

  @override
  EitherResult<UserModel> register({
    required UserRole role,
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    String? medicalId,
    String? phone,
    String? nationalId,
    String? dateOfBirth,
    String? gender,
    String? bloodType,
    String? address,
  }) {
    return safeCall(() async {
      final isDoctor = role == UserRole.doctor;

      final data = isDoctor
          ? <String, dynamic>{
              'name': name,
              'medical_id': medicalId,
              'email': email,
              'password': password,
              'password_confirmation': passwordConfirmation,
            }
          : <String, dynamic>{
              'name': name,
              'email': email,
              'password': password,
              'password_confirmation': passwordConfirmation,
              'phone': phone,
              'national_id': nationalId,
              'dob': dateOfBirth,
              'gender': gender,
              'blood_type': bloodType,
              'address': address,
            };

      final response = await _apiConsumer.post(
        isDoctor ? ApiEndpoints.registerDoctor : ApiEndpoints.registerPatient,
        data: data,
      );

      if (response is! Map<String, dynamic>) {
        throw const ServerFailure('Unexpected response format');
      }

      final userData = response['user'];
      if (userData is! Map<String, dynamic>) {
        final message = response['message'] as String?;
        throw ServerFailure(message ?? 'Registration failed');
      }

      final userModel = UserModel.fromJson(response);
      await _sessionManager.saveUserData(userModel);
      return userModel;
    });
  }

  @override
  EitherResult<void> forgotPassword({required String email}) {
    return safeCall(() async {
      final response = await _apiConsumer.post(
        ApiEndpoints.forgotPassword,
        data: {'email': email},
      );

      if (response is! Map<String, dynamic>) {
        throw const ServerFailure('Unexpected response format');
      }

      final message = response['message'] as String?;
      if (message != null && message.toLowerCase().contains('error')) {
        throw ServerFailure(message);
      }
    });
  }

  @override
  EitherResult<void> verifyOtp({
    required String email,
    required String otp,
  }) {
    return safeCall(() async {
      final response = await _apiConsumer.post(
        ApiEndpoints.verifyOtp,
        data: {'email': email, 'otp': otp},
      );

      if (response is! Map<String, dynamic>) {
        throw const ServerFailure('Unexpected response format');
      }

      final message = response['message'] as String?;
      if (message != null && message.toLowerCase().contains('error')) {
        throw ServerFailure(message);
      }
    });
  }

  @override
  EitherResult<void> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) {
    return safeCall(() async {
      final response = await _apiConsumer.post(
        ApiEndpoints.resetPassword,
        data: {
          'email': email,
          'otp': otp,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      if (response is! Map<String, dynamic>) {
        throw const ServerFailure('Unexpected response format');
      }

      final message = response['message'] as String?;
      if (message != null && message.toLowerCase().contains('error')) {
        throw ServerFailure(message);
      }
    });
  }

  @override
  EitherResult<void> logout() {
    return safeCall(() async {
      await _apiConsumer.post(ApiEndpoints.logout);
      await _sessionManager.logout();
    });
  }

  @override
  EitherResult<UserModel> registerDoctor({
    required String name,
    required String medicalId,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) {
    return safeCall(() async {
      final response = await _apiConsumer.post(
        ApiEndpoints.doctorRegister,
        data: {
          'name': name,
          'medical_id': medicalId,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      if (response is! Map<String, dynamic>) {
        throw const ServerFailure('Unexpected response format');
      }

      // Same access_token/token inconsistency as login — see AuthTokens.fromJson.
      final accessToken = (response['access_token'] ?? response['token']) as String?;
      final userJson = response['user'];
      if (accessToken == null || userJson is! Map<String, dynamic>) {
        final message = response['message'] as String?;
        throw ServerFailure(message ?? 'Registration failed');
      }

      final tokens = AuthTokens.fromJson(response);
      final user = UserModel.fromJson(userJson);

      _sessionManager.setRole(UserRole.doctor);
      await _sessionManager.login(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
        skipSetup: true,
      );

      return user;
    });
  }

  @override
  EitherResult<void> logout() async {
    try {
      await _apiConsumer.post(ApiEndpoints.logout);
    } catch (_) {
      // Ignore network/server errors here on purpose — the local session
      // is cleared below regardless, so the user is never stuck "logged
      // in" on this device just because the server call failed.
    }
    await _sessionManager.logout();
    return const Right(null);
  }

  @override
  EitherResult<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) {
    return safeCall(() async {
      await _apiConsumer.put(
        ApiEndpoints.changePassword,
        data: {
          'current_password': currentPassword,
          'password': newPassword,
          'password_confirmation': newPasswordConfirmation,
        },
      );
    });
  }
}
