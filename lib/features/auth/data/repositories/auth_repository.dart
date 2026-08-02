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
}
