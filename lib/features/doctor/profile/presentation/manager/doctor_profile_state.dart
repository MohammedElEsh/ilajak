import 'package:equatable/equatable.dart';

import '../../data/models/doctor_profile_model.dart';

class DoctorProfileState extends Equatable {
  const DoctorProfileState();

  @override
  List<Object?> get props => [];
}

class DoctorProfileInitial extends DoctorProfileState {
  const DoctorProfileInitial();
}

class DoctorProfileLoading extends DoctorProfileState {
  const DoctorProfileLoading();
}

class DoctorProfileLoaded extends DoctorProfileState {
  final DoctorProfileModel profile;
  final bool isUploadingAvatar;

  const DoctorProfileLoaded(this.profile, {this.isUploadingAvatar = false});

  DoctorProfileLoaded copyWith({
    DoctorProfileModel? profile,
    bool? isUploadingAvatar,
  }) {
    return DoctorProfileLoaded(
      profile ?? this.profile,
      isUploadingAvatar: isUploadingAvatar ?? this.isUploadingAvatar,
    );
  }

  @override
  List<Object?> get props => [profile, isUploadingAvatar];
}

class DoctorProfileError extends DoctorProfileState {
  final String message;

  const DoctorProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}
