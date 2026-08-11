import 'package:ilajak/core/errors/safe_call.dart';
import 'package:ilajak/core/services/session/session_manager.dart';
import 'package:ilajak/features/auth/data/models/auth_tokens.dart';
import 'package:ilajak/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  EitherResult<AuthTokens> login({
    required String email,
    required String password,
    bool rememberMe = false,
  });

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
  });

  EitherResult<void> forgotPassword({required String email});

  EitherResult<void> verifyOtp({required String email, required String otp});

  EitherResult<void> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  });

  EitherResult<void> logout();
}
