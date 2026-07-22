import 'package:equatable/equatable.dart';

class AuthLoginState extends Equatable {
  const AuthLoginState();

  @override
  List<Object?> get props => [];
}

class AuthLoginInitial extends AuthLoginState {
  const AuthLoginInitial();
}

class AuthLoginLoading extends AuthLoginState {
  const AuthLoginLoading();
}

class AuthLoginSuccess extends AuthLoginState {
  const AuthLoginSuccess();
}

class AuthLoginError extends AuthLoginState {
  final String message;

  const AuthLoginError({required this.message});

  @override
  List<Object?> get props => [message];
}
