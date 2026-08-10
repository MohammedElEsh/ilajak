import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilajak/features/patient/appointments/data/repos/doctors_repo.dart';
import 'package:ilajak/features/patient/appointments/presentation/manager/states/doctor_available_time_slots_state.dart';

class DoctorAvailableTimeSlotsCubit extends Cubit<DoctorAvailableTimeSlotsState> {
  final DoctorsRepo doctorsRepo;
  DoctorAvailableTimeSlotsCubit({required this.doctorsRepo})
      : super(DoctorAvailableTimeSlotsInitial());

  Future<void> getAvailableTimeSlots(int doctorId, DateTime date) async {
    emit(DoctorAvailableTimeSlotsLoading());
    final result = await doctorsRepo.getAvailableTimeSlots(doctorId, date);
    result.fold(
      (failure) => emit(
        DoctorAvailableTimeSlotsError(
          errorMessage: failure.message,
        ),
      ),
      (timeSlots) {
      
        emit(DoctorAvailableTimeSlotsLoaded(timeSlots: timeSlots));
      },
    );
  }
}