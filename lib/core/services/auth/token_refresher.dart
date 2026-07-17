import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../errors/failures.dart';
import '../../errors/safe_call.dart';
import '../../networking/api_endpoints.dart';
import '../logger/logger_service.dart';
import 'token_service.dart';

class TokenRefresher {
  final TokenService _tokenService;

  // Separate Dio — no interceptors, never causes a 401 loop
  final _dio = Dio(BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  TokenRefresher({required TokenService tokenService})
      : _tokenService = tokenService;

  /// Returns Right(unit) on success, Left(Failure) on failure.
  /// Failure types:
  /// - AuthFailure / ServerFailure(statusCode: 401) → refresh token expired
  /// - NetworkFailure → transient network error
  /// - Other Failure → server error, etc.
  Future<Either<Failure, void>> refresh() async {
    final refreshToken = await _tokenService.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      LoggerService.w('No refresh token stored — cannot refresh', tag: 'AUTH');
      return const Left(AuthFailure('No refresh token available'));
    }

    return safeCall(() async {
      final res = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.refresh,
        data: {'refreshToken': refreshToken},
      );

      final newAccess = res.data?['access_token'] as String?;
      final newRefresh = res.data?['refresh_token'] as String?;

      if (newAccess == null || newAccess.isEmpty) {
        LoggerService.e(
          'Refresh response missing access_token',
          tag: 'AUTH',
        );
        throw const ServerFailure('Invalid refresh response');
      }

      await _tokenService.saveTokens(
        accessToken: newAccess,
        refreshToken: newRefresh,
      );

      LoggerService.i('Token refresh succeeded — new tokens saved',
          tag: 'AUTH');
    });
  }
}
