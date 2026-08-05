import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilajak/features/patient/appointments/data/repos/doctors_repo.dart';
import 'package:ilajak/features/patient/appointments/presentation/manager/states/doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  DoctorsCubit({required this.doctorsRepo})
    : super(
        DoctorsInitial(),
      );
  final DoctorsRepo doctorsRepo;

  Future<void> getAllDoctors() async {
    emit(DoctorsLoading());
    final result = await doctorsRepo.getAllDoctors();
    result.fold(
      (failure) => emit(DoctorsError(errorMessage: failure.message)),
      (doctors) => emit(DoctorsLoaded(doctors: doctors)),
    );
  }
}