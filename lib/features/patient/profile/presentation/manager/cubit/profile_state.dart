part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

// Profile View

final class ProfileInitial extends ProfileState {}

final class GetProfileLoading extends ProfileState {}

final class GetProfileSuccess extends ProfileState {
  final ProfileModel profile;
  const GetProfileSuccess(this.profile);
}

final class GetProfileError extends ProfileState {
  final String error;
  const GetProfileError(this.error);
}

// Profile Personal Info
final class GetPersonalInfoLoading extends ProfileState {}

final class GetPersonalInfoSuccess extends ProfileState {
  final UserModel user;
  const GetPersonalInfoSuccess(this.user);
}

final class GetPersonalInfoError extends ProfileState {
  final String error;
  const GetPersonalInfoError(this.error);
}



