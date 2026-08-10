import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ilajak/features/auth/data/models/user_model.dart';
import 'package:ilajak/features/patient/profile/data/models/profile_model.dart';
import 'package:ilajak/features/patient/profile/data/repos/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileCubit(this.profileRepo) : super(ProfileInitial());
  // getProfile ===> ProfileView
  Future<void> getProfile() async {
    emit(GetProfileLoading());
    final result = await profileRepo.getProfile();
    result.fold(
      (failure) => emit(GetProfileError(failure.message)),
      (profile) => emit(GetProfileSuccess(profile)),
    );
  }
  // getPersonalInfo ===> PersonalInfoView
  Future<void> getPersonalInfo() async {
    emit(GetPersonalInfoLoading());
    final result = await profileRepo.getPersonalInfo();
    result.fold(
      (failure) => emit(GetPersonalInfoError(failure.message)),
      (user) => emit(GetPersonalInfoSuccess(user)),
    );
  }
}
