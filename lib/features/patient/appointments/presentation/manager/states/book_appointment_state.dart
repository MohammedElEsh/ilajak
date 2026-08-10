import 'package:ilajak/features/patient/appointments/data/models/book_appointment_response_model.dart';

abstract class BookAppointmentState {}

class BookAppointmentInitial extends BookAppointmentState {}

class BookAppointmentLoading extends BookAppointmentState {}

class BookAppointmentSuccess extends BookAppointmentState {
  final BookAppointmentResponseModel appointment;

  BookAppointmentSuccess(this.appointment);
}

class BookAppointmentError extends BookAppointmentState {
  final String message;

  BookAppointmentError(this.message);
}
