import 'package:equatable/equatable.dart';

class AuthVerifyOtpState extends Equatable {
  const AuthVerifyOtpState();

  @override
  List<Object?> get props => [];
}

class AuthVerifyOtpInitial extends AuthVerifyOtpState {
  const AuthVerifyOtpInitial();
}

class AuthVerifyOtpLoading extends AuthVerifyOtpState {
  const AuthVerifyOtpLoading();
}

class AuthVerifyOtpSuccess extends AuthVerifyOtpState {
  const AuthVerifyOtpSuccess();
}

class AuthVerifyOtpError extends AuthVerifyOtpState {
  final String message;

  const AuthVerifyOtpError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthVerifyOtpResendLoading extends AuthVerifyOtpState {
  const AuthVerifyOtpResendLoading();
}

class AuthVerifyOtpResendSuccess extends AuthVerifyOtpState {
  const AuthVerifyOtpResendSuccess();
}
