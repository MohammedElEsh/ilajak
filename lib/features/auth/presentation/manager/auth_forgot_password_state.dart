import 'package:equatable/equatable.dart';

class AuthForgotPasswordState extends Equatable {
  const AuthForgotPasswordState();

  @override
  List<Object?> get props => [];
}

class AuthForgotPasswordInitial extends AuthForgotPasswordState {
  const AuthForgotPasswordInitial();
}

class AuthForgotPasswordLoading extends AuthForgotPasswordState {
  const AuthForgotPasswordLoading();
}

class AuthForgotPasswordSuccess extends AuthForgotPasswordState {
  const AuthForgotPasswordSuccess();
}

class AuthForgotPasswordError extends AuthForgotPasswordState {
  final String message;

  const AuthForgotPasswordError({required this.message});

  @override
  List<Object?> get props => [message];
}
