import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilajak/core/services/media/media_service.dart';
import 'package:ilajak/core/shared/feedback/feedback_handler.dart';
import 'package:ilajak/features/auth/data/repositories/auth_repository.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/repositories/doctor_profile_repository.dart';
import 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final DoctorProfileRepository _doctorProfileRepository;
  final AuthRepository _authRepository;
  final MediaService _mediaService;

  DoctorProfileCubit(
    this._doctorProfileRepository,
    this._authRepository,
    this._mediaService,
  ) : super(const DoctorProfileInitial());

  Future<void> loadProfile() async {
    emit(const DoctorProfileLoading());
    final result = await _doctorProfileRepository.getProfile();
    result.fold(
      (failure) => emit(DoctorProfileError(message: failure.message)),
      (profile) => emit(DoctorProfileLoaded(profile)),
    );
  }

  /// Picks an image and uploads it as the new avatar.
  ///
  /// NOTE: a failure here calls [FeedbackHandler] directly instead of
  /// emitting an error state — deliberately, so a failed upload just shows
  /// a toast and keeps the already-loaded profile on screen, rather than
  /// replacing the whole screen with the AppErrorWidget/retry state (which
  /// is meant for the initial load failing, not a background upload).
  /// Flagged in chat — easy to change if you'd rather route it through a
  /// state + BlocListener instead.
  Future<void> changeAvatar() async {
    final current = state;
    if (current is! DoctorProfileLoaded) return;

    final picked = await _mediaService.pickImage(ImageSource.gallery);
    if (picked == null) return;

    emit(current.copyWith(isUploadingAvatar: true));
    final result = await _doctorProfileRepository.uploadAvatar(picked);
    result.fold(
      (failure) {
        FeedbackHandler.error(failure.message);
        emit(current.copyWith(isUploadingAvatar: false));
      },
      (avatarUrl) {
        emit(current.copyWith(
          profile: current.profile.copyWith(avatarUrl: avatarUrl),
          isUploadingAvatar: false,
        ));
      },
    );
  }

  Future<void> logout() => _authRepository.logout();
}
