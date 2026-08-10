import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilajak/features/patient/appointments/data/models/book_appointment_request_model.dart';
import 'package:ilajak/features/patient/appointments/data/repos/doctors_repo.dart';
import 'package:ilajak/features/patient/appointments/presentation/manager/states/book_appointment_state.dart';

class BookAppointmentCubit extends Cubit<BookAppointmentState> {
  final DoctorsRepo doctorsRepo;

  BookAppointmentCubit(this.doctorsRepo)
      : super(BookAppointmentInitial());

  Future<void> bookAppointment({
    required int doctorId,
    required int clinicId,
    required String date,
    required String slotTime,
  }) async {
    emit(BookAppointmentLoading());

    final request = BookAppointmentRequest(
      doctorId: doctorId,
      clinicId: clinicId,
      date: date,
      slotTime: slotTime,
    );

    final result = await doctorsRepo.bookAppointment(request);

    result.fold(
      (failure) {
        emit(BookAppointmentError(failure.message));
      },
      (appointment) {
        emit(BookAppointmentSuccess(appointment));
      },
    );
  }
}