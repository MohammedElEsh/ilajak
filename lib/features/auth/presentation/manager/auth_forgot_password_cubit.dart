import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repository.dart';
import 'auth_forgot_password_state.dart';

class AuthForgotPasswordCubit extends Cubit<AuthForgotPasswordState> {
  final AuthRepository _authRepository;

  AuthForgotPasswordCubit(this._authRepository)
    : super(const AuthForgotPasswordInitial());

  Future<void> sendResetCode({required String email}) async {
    emit(const AuthForgotPasswordLoading());
    final result = await _authRepository.forgotPassword(email: email);
    result.fold(
      (failure) => emit(AuthForgotPasswordError(message: failure.message)),
      (_) => emit(const AuthForgotPasswordSuccess()),
    );
  }
}
