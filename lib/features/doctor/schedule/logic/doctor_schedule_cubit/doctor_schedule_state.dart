import 'package:equatable/equatable.dart';
import 'package:ilajak/features/doctor/schedule/data/models/appointment/appointment_model.dart';

class DoctorScheduleState extends Equatable {
  const DoctorScheduleState();

  @override
  List<Object?> get props => [];
}

class DoctorScheduleInitial extends DoctorScheduleState {
  const DoctorScheduleInitial();
}

class DoctorScheduleLoading extends DoctorScheduleState {
  const DoctorScheduleLoading();
}

class DoctorScheduleLoaded extends DoctorScheduleState {
  final List<AppointmentModel> appointments;

  const DoctorScheduleLoaded({required this.appointments});

  @override
  List<Object?> get props => [appointments];
}

class DoctorScheduleError extends DoctorScheduleState {
  final String message;

  const DoctorScheduleError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Emitted (briefly, before a reload) after a Confirm/Complete/Cancel
/// action succeeds — lets the view show a snackbar/toast without needing
/// a separate one-shot event bus.
class DoctorScheduleActionSuccess extends DoctorScheduleState {
  final List<AppointmentModel> appointments;

  const DoctorScheduleActionSuccess({required this.appointments});

  @override
  List<Object?> get props => [appointments];
}
