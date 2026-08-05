import 'package:fpdart/fpdart.dart';
import 'package:ilajak/core/errors/failures.dart';
import 'package:ilajak/features/auth/data/models/user_model.dart';
import 'package:ilajak/features/patient/profile/data/models/profile_model.dart';

abstract class ProfileRepo {
  // getProfile ===> ProfileView
  Future<Either<Failure, ProfileModel>> getProfile();
  // getPersonalInfo ===> PersonalInfoView
  // It should carry the current user data
  // I should cache this data in local storage
  // So, go to Auth and do this after Register & Login save data by something special
  Future<Either<Failure, UserModel>> getPersonalInfo();
}