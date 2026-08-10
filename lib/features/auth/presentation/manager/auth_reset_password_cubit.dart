import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repository.dart';
import 'auth_reset_password_state.dart';

class AuthResetPasswordCubit extends Cubit<AuthResetPasswordState> {
  final AuthRepository _authRepository;

  AuthResetPasswordCubit(this._authRepository)
      : super(const AuthResetPasswordInitial());

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(const AuthResetPasswordLoading());
    final result = await _authRepository.resetPassword(
      email: email,
      otp: otp,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    result.fold(
      (failure) => emit(AuthResetPasswordError(message: failure.message)),
      (_) => emit(const AuthResetPasswordSuccess()),
    );
  }
}
