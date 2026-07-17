import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(super.message, {this.statusCode});

  factory ServerFailure.fromResponse({
    required String message,
    int? statusCode,
  }) {
    return ServerFailure(message, statusCode: statusCode);
  }

  @override
  List<Object?> get props => [message, statusCode];
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred']);

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed']);

  @override
  List<Object?> get props => [message];
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unexpected error occurred']);

  @override
  List<Object?> get props => [message];
}
