// import 'package:stylish/core/constants/app_assets.dart';
// import 'package:stylish/features/auth/data/models/user_model.dart';
//
// import '../../../../core/errors/failures.dart';
// import '../../../../core/errors/safe_call.dart';
// import '../../../../core/networking/api_consumer.dart';
// import '../../../../core/networking/api_endpoints.dart';
// import '../../../../core/services/session/session_manager.dart';
// import '../models/auth_tokens.dart';
// import 'auth_repository.dart';
//
// class AuthRepositoryImpl implements AuthRepository {
//   final ApiConsumer _apiConsumer;
//   final SessionManager _sessionManager;
//
//   AuthRepositoryImpl({
//     required ApiConsumer apiConsumer,
//     required SessionManager sessionManager,
//   })  : _apiConsumer = apiConsumer,
//         _sessionManager = sessionManager;
//
//   @override
//   EitherResult<AuthTokens> login({
//     required String email,
//     required String password,
//   }) {
//     return safeCall(() async {
//       final response = await _apiConsumer.post(
//         ApiEndpoints.login,
//         data: {'email': email, 'password': password},
//       );
//
//       if (response is! Map<String, dynamic>) {
//         throw const ServerFailure('Unexpected response format');
//       }
//
//       if (!response.containsKey('access_token') ||
//           !response.containsKey('refresh_token')) {
//         final message = response['message'] as String?;
//         throw ServerFailure(message ?? 'Incorrect email or password');
//       }
//
//       final tokens = AuthTokens.fromJson(response);
//
//       await _sessionManager.login(
//         accessToken: tokens.accessToken,
//         refreshToken: tokens.refreshToken,
//       );
//
//       return tokens;
//     });
//   }
//
//   @override
//   EitherResult<UserModel> register({
//     required String name,
//     required String email,
//     required String password,
//   }) {
//     return safeCall(() async {
//       final response = await _apiConsumer.post(
//         ApiEndpoints.register,
//         data: {
//           'name': name,
//           'email': email,
//           'password': password,
//           'avatar': AppAssets.defaultUserAvatar,
//         },
//       );
//
//       if (response is! Map<String, dynamic>) {
//         throw const ServerFailure('Unexpected response format');
//       }
//
//       if (response.containsKey('message')) {
//         final message = response['message'] as String?;
//         if (message != null && message.isNotEmpty) {
//           throw ServerFailure(message);
//         }
//       }
//
//       return UserModel.fromJson(response);
//     });
//   }
//
//   @override
//   EitherResult<bool> checkEmailAvailability({
//     required String email,
//   }) {
//     return safeCall(() async {
//       final response = await _apiConsumer.post(
//         ApiEndpoints.checkEmailAvailability,
//         data: {'email': email},
//       );
//
//       if (response is! Map<String, dynamic>) {
//         throw const ServerFailure('Unexpected response format');
//       }
//
//       return response['isAvailable'] as bool;
//     });
//   }
// }
