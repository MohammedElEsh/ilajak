import 'package:equatable/equatable.dart';

class AuthResetPasswordState extends Equatable {
  const AuthResetPasswordState();

  @override
  List<Object?> get props => [];
}

class AuthResetPasswordInitial extends AuthResetPasswordState {
  const AuthResetPasswordInitial();
}

class AuthResetPasswordLoading extends AuthResetPasswordState {
  const AuthResetPasswordLoading();
}

class AuthResetPasswordSuccess extends AuthResetPasswordState {
  const AuthResetPasswordSuccess();
}

class AuthResetPasswordError extends AuthResetPasswordState {
  final String message;

  const AuthResetPasswordError({required this.message});

  @override
  List<Object?> get props => [message];
}
