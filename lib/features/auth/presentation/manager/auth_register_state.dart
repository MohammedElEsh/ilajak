import 'package:equatable/equatable.dart';

class AuthRegisterState extends Equatable {
  const AuthRegisterState();

  @override
  List<Object?> get props => [];
}

class AuthRegisterInitial extends AuthRegisterState {
  const AuthRegisterInitial();
}

class AuthRegisterLoading extends AuthRegisterState {
  const AuthRegisterLoading();
}

class AuthRegisterSuccess extends AuthRegisterState {
  const AuthRegisterSuccess();
}

class AuthRegisterError extends AuthRegisterState {
  final String message;

  const AuthRegisterError({required this.message});

  @override
  List<Object?> get props => [message];
}
