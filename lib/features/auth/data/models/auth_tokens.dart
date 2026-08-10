import 'package:equatable/equatable.dart';

class AuthTokens extends Equatable {
  final String accessToken;
  final String? refreshToken;

  const AuthTokens({
    required this.accessToken,
    this.refreshToken,
  });

  /// NOTE: the Postman collection's saved examples are inconsistent —
  /// "Patient Login" returns `access_token`, "Doctor Login" returns
  /// `token`. Reading both defensively here so we don't hard-fail doctor
  /// login if that's really how the deployed backend behaves. Worth a
  /// 30-second re-test against the live backend to confirm which one (or
  /// both) is current — flagged in chat.
  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    final token = (json['access_token'] ?? json['token']) as String;
    return AuthTokens(
      accessToken: token,
      refreshToken: json['refresh_token'] as String?,
    );
  }

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
