import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_register_state.dart';

class AuthRegisterCubit extends Cubit<AuthRegisterState> {
  AuthRegisterCubit() : super(const AuthRegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String nationalId,
    required String dateOfBirth,
    required String gender,
    required String bloodType,
    required String address,
    required String password,
  }) async {
    emit(const AuthRegisterLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(const AuthRegisterSuccess());
  }
}
