import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repository.dart';
import 'auth_login_state.dart';

class AuthLoginCubit extends Cubit<AuthLoginState> {
  final AuthRepository _authRepository;

  AuthLoginCubit(this._authRepository) : super(const AuthLoginInitial());

  Future<void> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    emit(const AuthLoginLoading());
    final result = await _authRepository.login(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
    result.fold(
      (failure) => emit(AuthLoginError(message: failure.message)),
      (_) => emit(const AuthLoginSuccess()),
    );
  }
}
