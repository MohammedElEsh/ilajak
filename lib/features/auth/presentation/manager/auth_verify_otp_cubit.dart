import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_verify_otp_state.dart';

class AuthVerifyOtpCubit extends Cubit<AuthVerifyOtpState> {
  AuthVerifyOtpCubit() : super(const AuthVerifyOtpInitial());

  Future<void> verifyOtp({required String email, required String code}) async {
    emit(const AuthVerifyOtpLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(const AuthVerifyOtpSuccess());
  }

  Future<void> resendOtp({required String email}) async {
    emit(const AuthVerifyOtpLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(const AuthVerifyOtpResendSuccess());
  }
}
