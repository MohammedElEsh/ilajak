import 'package:ilajak/core/errors/failures.dart';
import 'package:ilajak/core/errors/safe_call.dart';
import 'package:ilajak/core/networking/api_consumer.dart';
import 'package:ilajak/core/networking/api_endpoints.dart';
import 'package:ilajak/core/services/session/session_manager.dart';

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

      final accessToken = response['access_token'] as String?;
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
          orElse: () => UserRole.patient,
        );
        _sessionManager.setRole(role);
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
}
