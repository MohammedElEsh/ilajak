import '../../../../core/errors/safe_call.dart';
import '../models/auth_tokens.dart';
import '../models/user_model.dart';

abstract class AuthRepository {
  EitherResult<AuthTokens> login({
    required String email,
    required String password,
  });

  EitherResult<UserModel> register({
    required String name,
    required String email,
    required String password,
  });

  EitherResult<bool> checkEmailAvailability({
    required String email,
  });

  /// POST {{base_url}}/doctor/register — separate endpoint/payload shape
  /// from patient [register] (only name/email/password overlap), so it
  /// gets its own method rather than reusing [register] with optional
  /// params. Logs the doctor in immediately on success (the response
  /// already includes a fresh token) — see chat note if you'd rather send
  /// them to the login screen instead.
  EitherResult<UserModel> registerDoctor({
    required String name,
    required String medicalId,
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  /// Always clears the local session (tokens + session status) even if the
  /// server call fails — the user should never get stuck "logged in" on
  /// this device just because /logout timed out or 401'd.
  EitherResult<void> logout();

  /// PUT {{base_url}}/user/change-password — shared by patient and doctor
  /// accounts alike (endpoint is role-agnostic).
  EitherResult<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  });
}
