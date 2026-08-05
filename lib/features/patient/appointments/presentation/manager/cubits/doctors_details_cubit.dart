import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilajak/features/patient/appointments/data/repos/doctors_repo.dart';
import 'package:ilajak/features/patient/appointments/presentation/manager/states/doctors_details_state.dart';

class DoctorsDetailsCubit extends Cubit<DoctorsDetailsState> {
  final DoctorsRepo doctorsRepo;
  DoctorsDetailsCubit({required this.doctorsRepo}) : super(DoctorsDetailsInitial());

  Future<void> getSingleDoctorDetails(int doctorId) async {
    emit(DoctorsDetailsLoading());
    final result = await doctorsRepo.getSingleDoctorDetails(doctorId);
    result.fold(
      (failure) => emit(
        DoctorsDetailsError(
          errorMessage: failure.message,
         
        ),
      ),
      (doctorsDetails) => emit(
        DoctorsDetailsLoaded(doctorDetails: doctorsDetails),
      ),
    );
  }
}