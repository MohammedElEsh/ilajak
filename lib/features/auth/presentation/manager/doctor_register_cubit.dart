import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repository.dart';
import 'doctor_register_state.dart';

class DoctorRegisterCubit extends Cubit<DoctorRegisterState> {
  final AuthRepository _authRepository;

  DoctorRegisterCubit(this._authRepository)
      : super(const DoctorRegisterInitial());

  Future<void> register({
    required String name,
    required String medicalId,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(const DoctorRegisterLoading());
    final result = await _authRepository.registerDoctor(
      name: name,
      medicalId: medicalId,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    result.fold(
      (failure) => emit(DoctorRegisterError(message: failure.message)),
      (_) => emit(const DoctorRegisterSuccess()),
    );
  }
}
