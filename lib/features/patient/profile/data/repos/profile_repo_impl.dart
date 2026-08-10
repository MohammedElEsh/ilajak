import 'package:fpdart/fpdart.dart';
import 'package:ilajak/core/errors/failures.dart';
import 'package:ilajak/core/errors/safe_call.dart';
import 'package:ilajak/core/networking/api_consumer.dart';
import 'package:ilajak/core/networking/api_endpoints.dart';
import 'package:ilajak/core/services/session/session_manager.dart';
import 'package:ilajak/features/auth/data/models/user_model.dart';
import 'package:ilajak/features/patient/profile/data/models/profile_model.dart';
import 'package:ilajak/features/patient/profile/data/repos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiConsumer apiConsumer;
  final SessionManager sessionManager;

  ProfileRepoImpl({
    required this.apiConsumer,
    required this.sessionManager,
  });

  @override
  Future<Either<Failure, ProfileModel>> getProfile() {
    return safeCall(() async {
      final response = await apiConsumer.get(ApiEndpoints.profileOverView);

      if (response is! Map<String, dynamic>) {
        throw const ServerFailure('Unexpected response format');
      }

      final profileJson = response['data'] is Map<String, dynamic>
          ? response['data'] as Map<String, dynamic>
          : response;

      return ProfileModel.fromJson(profileJson);
    });
  }

  @override
  Future<Either<Failure, UserModel>> getPersonalInfo() async {
    try {
      final cachedUser = sessionManager.getUserData();
      if (cachedUser != null) {
        return Right(cachedUser);
      }
      return const Left(CacheFailure('No user data found in local storage'));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}