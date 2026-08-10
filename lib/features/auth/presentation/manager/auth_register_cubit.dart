import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/session/session_manager.dart';
import '../../data/repositories/auth_repository.dart';
import 'auth_register_state.dart';

class AuthRegisterCubit extends Cubit<AuthRegisterState> {
  final AuthRepository _authRepository;

  AuthRegisterCubit(this._authRepository) : super(const AuthRegisterInitial());

  Future<void> register({
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
  }) async {
    emit(const AuthRegisterLoading());
    final result = await _authRepository.register(
      role: role,
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      medicalId: medicalId,
      phone: phone,
      nationalId: nationalId,
      dateOfBirth: dateOfBirth,
      gender: gender,
      bloodType: bloodType,
      address: address,
    );
    result.fold(
      (failure) => emit(AuthRegisterError(message: failure.message)),
      (_) => emit(const AuthRegisterSuccess()),
    );
  }
}
