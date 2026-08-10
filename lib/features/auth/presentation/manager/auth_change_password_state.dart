import 'package:equatable/equatable.dart';

class AuthChangePasswordState extends Equatable {
  const AuthChangePasswordState();

  @override
  List<Object?> get props => [];
}

class AuthChangePasswordInitial extends AuthChangePasswordState {
  const AuthChangePasswordInitial();
}

class AuthChangePasswordLoading extends AuthChangePasswordState {
  const AuthChangePasswordLoading();
}

class AuthChangePasswordSuccess extends AuthChangePasswordState {
  const AuthChangePasswordSuccess();
}

class AuthChangePasswordError extends AuthChangePasswordState {
  final String message;

  const AuthChangePasswordError({required this.message});

  @override
  List<Object?> get props => [message];
}
