import 'package:ilajak/features/patient/appointments/data/models/doctors_details_model.dart';

abstract class DoctorsDetailsState {}

class DoctorsDetailsInitial extends DoctorsDetailsState {}

class DoctorsDetailsLoading extends DoctorsDetailsState {}

class DoctorsDetailsLoaded extends DoctorsDetailsState {
  final DoctorDetailsModel doctorDetails;
  DoctorsDetailsLoaded({required this.doctorDetails});
}

class DoctorsDetailsError extends DoctorsDetailsState {
  final String errorMessage;
  final int? statusCode;
  DoctorsDetailsError({required this.errorMessage, this.statusCode});
}