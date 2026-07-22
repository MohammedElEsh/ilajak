import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_forgot_password_state.dart';

class AuthForgotPasswordCubit extends Cubit<AuthForgotPasswordState> {
  AuthForgotPasswordCubit() : super(const AuthForgotPasswordInitial());

  Future<void> sendResetLink({required String email}) async {
    emit(const AuthForgotPasswordLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(const AuthForgotPasswordSuccess());
  }
}
