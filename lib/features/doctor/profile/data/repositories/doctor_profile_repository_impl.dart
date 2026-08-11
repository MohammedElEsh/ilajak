import 'package:dio/dio.dart';
import 'package:ilajak/core/errors/failures.dart';
import 'package:ilajak/core/errors/safe_call.dart';
import 'package:ilajak/core/networking/api_consumer.dart';
import 'package:ilajak/core/networking/api_endpoints.dart';
import 'package:image_picker/image_picker.dart';
import '../models/doctor_profile_model.dart';
import 'doctor_profile_repository.dart';

class DoctorProfileRepositoryImpl implements DoctorProfileRepository {
  final ApiConsumer _apiConsumer;

  DoctorProfileRepositoryImpl({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  @override
  EitherResult<DoctorProfileModel> getProfile() {
    return safeCall(() async {
      final response = await _apiConsumer.get(ApiEndpoints.doctorProfile);

      if (response is! Map<String, dynamic>) {
        throw const ServerFailure('Unexpected response format');
      }

      final data = response['data'];
      if (data is! Map<String, dynamic>) {
        throw const ServerFailure('Unexpected response format');
      }

      return DoctorProfileModel.fromJson(data);
    });
  }

  @override
  EitherResult<String> uploadAvatar(XFile file) {
    return safeCall(() async {
      final response = await _apiConsumer.post(
        ApiEndpoints.doctorProfileAvatar,
        data: {
          'avatar': await MultipartFile.fromFile(
            file.path,
            filename: file.name,
          ),
        },
        isFormData: true,
      );

      if (response is! Map<String, dynamic>) {
        throw const ServerFailure('Unexpected response format');
      }

      final avatarUrl = response['avatar_url'] as String?;
      if (avatarUrl == null || avatarUrl.isEmpty) {
        throw const ServerFailure('Avatar upload failed');
      }

      return avatarUrl;
    });
  }
}
