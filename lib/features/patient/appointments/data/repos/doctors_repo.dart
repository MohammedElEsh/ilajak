import 'package:fpdart/fpdart.dart';
import 'package:ilajak/core/errors/failures.dart';
import 'package:ilajak/features/patient/appointments/data/models/book_appointment_request_model.dart';
import 'package:ilajak/features/patient/appointments/data/models/book_appointment_response_model.dart';
import 'package:ilajak/features/patient/appointments/data/models/doctors_model.dart';
import 'package:ilajak/features/patient/appointments/data/models/doctors_details_model.dart';

abstract class DoctorsRepo {
  Future<Either<Failure, DoctorDetailsModel>> getSingleDoctorDetails(
    int doctorId,
  );
  Future<Either<Failure, List<DoctorModel>>> getDoctors({
    String? search,
    String? specialization,
  });

  Future<Either<Failure, List<String>>> getAvailableTimeSlots(
    int doctorId,
    DateTime date,
  );
  Future<Either<Failure, BookAppointmentResponseModel>> bookAppointment(
    BookAppointmentRequest request,
  );
}
