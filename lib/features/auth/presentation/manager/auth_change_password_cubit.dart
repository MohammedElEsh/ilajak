import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repository.dart';
import 'auth_change_password_state.dart';

class AuthChangePasswordCubit extends Cubit<AuthChangePasswordState> {
  final AuthRepository _authRepository;

  AuthChangePasswordCubit(this._authRepository)
      : super(const AuthChangePasswordInitial());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmation,
  }) async {
    emit(const AuthChangePasswordLoading());
    final result = await _authRepository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      newPasswordConfirmation: confirmation,
    );
    result.fold(
      (failure) => emit(AuthChangePasswordError(message: failure.message)),
      (_) => emit(const AuthChangePasswordSuccess()),
    );
  }
}
