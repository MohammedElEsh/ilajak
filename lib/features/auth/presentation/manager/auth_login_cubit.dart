import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_login_state.dart';

class AuthLoginCubit extends Cubit<AuthLoginState> {
  AuthLoginCubit() : super(const AuthLoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoginLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(const AuthLoginSuccess());
  }
}
