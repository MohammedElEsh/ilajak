import '../logger/logger_service.dart';
import '../storage/secure_storage_service.dart';

class TokenService {
  final SecureStorageService _secureStorage;

  static const _accessKey = 'access_token';
  static const _refreshKey = 'refresh_token';

  TokenService({required SecureStorageService secureStorage})
      : _secureStorage = secureStorage;

  /// Always reads from SecureStorage — guarantees that any external change to
  /// stored tokens is immediately visible on the next request.
  Future<String?> getAccessToken() => _secureStorage.read(_accessKey);

  Future<String?> getRefreshToken() => _secureStorage.read(_refreshKey);

  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _secureStorage.write(_accessKey, accessToken);
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _secureStorage.write(_refreshKey, refreshToken);
    }
    LoggerService.i('Tokens saved', tag: 'TokenService');
  }

  Future<void> clearTokens() async {
    await _secureStorage.delete(_accessKey);
    await _secureStorage.delete(_refreshKey);
    LoggerService.w('Tokens cleared', tag: 'TokenService');
  }
}
