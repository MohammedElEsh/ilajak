import 'package:ilajak/features/patient/appointments/data/models/doctors_model.dart';

abstract class DoctorsState {}

class DoctorsInitial extends DoctorsState {}

class DoctorsLoading extends DoctorsState {}

class DoctorsLoaded extends DoctorsState {
  final List<DoctorModel> doctors;
  DoctorsLoaded({required this.doctors});
}

class DoctorsError extends DoctorsState {
  final String errorMessage;
  final int? statusCode;
  DoctorsError({required this.errorMessage, this.statusCode});
}