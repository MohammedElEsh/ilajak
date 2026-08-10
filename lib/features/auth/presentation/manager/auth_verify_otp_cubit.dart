import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repository.dart';
import 'auth_verify_otp_state.dart';

class AuthVerifyOtpCubit extends Cubit<AuthVerifyOtpState> {
  final AuthRepository _authRepository;

  AuthVerifyOtpCubit(this._authRepository)
      : super(const AuthVerifyOtpInitial());

  Future<void> verifyOtp({required String email, required String code}) async {
    emit(const AuthVerifyOtpLoading());
    final result = await _authRepository.verifyOtp(email: email, otp: code);
    result.fold(
      (failure) => emit(AuthVerifyOtpError(message: failure.message)),
      (_) => emit(const AuthVerifyOtpSuccess()),
    );
  }

  Future<void> resendOtp({required String email}) async {
    emit(const AuthVerifyOtpResendLoading());
    final result = await _authRepository.forgotPassword(email: email);
    result.fold(
      (failure) => emit(AuthVerifyOtpError(message: failure.message)),
      (_) => emit(const AuthVerifyOtpResendSuccess()),
    );
  }
}
