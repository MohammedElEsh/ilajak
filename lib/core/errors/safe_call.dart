import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../di/injection.dart';
import '../services/connectivity/connectivity_service.dart';
import '../services/logger/logger_service.dart';
import 'failures.dart';

typedef EitherResult<T> = Future<Either<Failure, T>>;

Future<Either<Failure, T>> safeCall<T>(
  Future<T> Function() call, {
  ConnectivityService? connectivityService,
}) async {
  final service = connectivityService ?? sl<ConnectivityService>();
  final connected = await service.isConnected;
  if (!connected) {
    LoggerService.w('No connectivity — aborting safeCall', tag: 'SafeCall');
    return const Left(NetworkFailure());
  }

  try {
    final result = await call();
    return Right(result);
  } on DioException catch (e, stack) {
    LoggerService.e('DioException in safeCall', error: e, stackTrace: stack, tag: 'SafeCall');
    return Left(_handleDioException(e));
  } on SocketException catch (e) {
    LoggerService.w('SocketException: ${e.message}', tag: 'SafeCall');
    return const Left(NetworkFailure());
  } catch (e, stack) {
    LoggerService.e('Unknown error in safeCall', error: e, stackTrace: stack, tag: 'SafeCall');
    return Left(UnknownFailure(e.toString()));
  }
}

Failure _handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      return const NetworkFailure('Connection timed out');
    case DioExceptionType.connectionError:
      return const NetworkFailure();
    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      final message = e.response?.data is Map
          ? e.response?.data['message'] ?? 'Server error'
          : 'Server error';
      if (statusCode == 401) return const AuthFailure();
      return ServerFailure(message, statusCode: statusCode);
    case DioExceptionType.cancel:
      return const NetworkFailure('Request cancelled');
    default:
      return UnknownFailure(e.message ?? 'Unknown error');
  }
}
