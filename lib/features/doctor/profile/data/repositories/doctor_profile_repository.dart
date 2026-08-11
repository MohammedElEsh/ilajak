import 'package:ilajak/core/errors/safe_call.dart';
import 'package:image_picker/image_picker.dart';

import '../models/doctor_profile_model.dart';

abstract class DoctorProfileRepository {
  /// GET {{base_url}}/doctor/profile
  EitherResult<DoctorProfileModel> getProfile();

  /// POST {{base_url}}/doctor/profile/avatar (multipart)
  /// Returns the new `avatar_url`.
  EitherResult<String> uploadAvatar(XFile file);
}
