

abstract class DoctorAvailableTimeSlotsState {}

class DoctorAvailableTimeSlotsInitial extends DoctorAvailableTimeSlotsState {}

class DoctorAvailableTimeSlotsLoading extends DoctorAvailableTimeSlotsState {}

class DoctorAvailableTimeSlotsLoaded extends DoctorAvailableTimeSlotsState {
  final List<String> timeSlots;
  DoctorAvailableTimeSlotsLoaded({required this.timeSlots});
}

class DoctorAvailableTimeSlotsError extends DoctorAvailableTimeSlotsState {
  final String errorMessage;
  final int? statusCode;
  DoctorAvailableTimeSlotsError({required this.errorMessage, this.statusCode});
}