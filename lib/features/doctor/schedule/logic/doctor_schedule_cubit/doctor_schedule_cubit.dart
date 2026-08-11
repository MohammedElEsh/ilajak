import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilajak/features/doctor/schedule/domain/repositories/appointments_repository.dart';

import 'doctor_schedule_state.dart';

class DoctorScheduleCubit extends Cubit<DoctorScheduleState> {
  final AppointmentsRepository _appointmentsRepository;

  DoctorScheduleCubit(this._appointmentsRepository) : super(const DoctorScheduleInitial());

  Future<void> loadAppointments() async {
    emit(const DoctorScheduleLoading());
    final result = await _appointmentsRepository.getMyAppointments();
    result.fold(
      (failure) => emit(DoctorScheduleError(message: failure.message)),
      (appointments) => emit(DoctorScheduleLoaded(appointments: appointments)),
    );
  }

  Future<void> updateStatus({required int appointmentId, required String status}) async {
    final result = await _appointmentsRepository.updateAppointmentStatus(
      appointmentId: appointmentId,
      status: status,
    );
    await result.fold(
      (failure) async => emit(DoctorScheduleError(message: failure.message)),
      (_) async => loadAppointments(),
    );
  }
}
