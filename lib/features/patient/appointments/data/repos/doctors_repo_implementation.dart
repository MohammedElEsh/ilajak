import 'package:fpdart/fpdart.dart';
import 'package:ilajak/core/errors/failures.dart';
import 'package:ilajak/core/formatters/date_formatter.dart';
import 'package:ilajak/core/networking/api_consumer.dart';
import 'package:ilajak/core/networking/api_endpoints.dart';
import 'package:ilajak/features/patient/appointments/data/models/book_appointment_request_model.dart';
import 'package:ilajak/features/patient/appointments/data/models/book_appointment_response_model.dart';
import 'package:ilajak/features/patient/appointments/data/models/doctors_details_model.dart';
import 'package:ilajak/features/patient/appointments/data/models/doctors_model.dart';
import 'package:ilajak/features/patient/appointments/data/repos/doctors_repo.dart';

class DoctorsRepoImplementation implements DoctorsRepo {
  final ApiConsumer apiConsumer;

  DoctorsRepoImplementation(this.apiConsumer);

  @override
  Future<Either<Failure, DoctorDetailsModel>> getSingleDoctorDetails(
    int doctorId,
  ) async {
    try {
      final response = await apiConsumer.get(
        '${ApiEndpoints.doctors}/$doctorId',
      );
      final doctor = DoctorDetailsModel.fromJson(response['data']);
      return right(doctor);
    } catch (e) {
      return left(ServerFailure(e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctors({
    String? search,
    String? specialization,
  }) async {
    try {
      final response = await apiConsumer.get(
        ApiEndpoints.doctors,
        queryParameters: {
          if (search != null && search.isNotEmpty) "search": search,
          if (specialization != null && specialization.isNotEmpty)
            "specialization": specialization,
        },
      );

      final doctors = (response['data']['data'] as List)
          .map((e) => DoctorModel.fromJson(e))
          .toList();

      return right(doctors);
    } catch (e) {
      return left(ServerFailure(e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAvailableTimeSlots(
    int doctorId,
    DateTime date,
  ) async {
    try {
      final response = await apiConsumer.get(
        '${ApiEndpoints.doctors}/$doctorId/available-slots?date=${DateFormatter.formatToYMD(date)}',
      );

      final slotsList = response['available_slots'] as List? ?? [];

      final timeSlots = slotsList
          .map((e) => e['start_time']?.toString() ?? '')
          .where((time) => time.isNotEmpty)
          .toList();

      return right(timeSlots);
    } catch (e) {
      return left(ServerFailure(e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, BookAppointmentResponseModel>> bookAppointment(
    BookAppointmentRequest request,
  ) async {
    try {
      final response = await apiConsumer.post(
        ApiEndpoints.bookAppointment,
        data: request.toJson(),
      );

      final appointment = BookAppointmentResponseModel.fromJson(
        response['data'],
      );

      return right(appointment);
    } catch (e) {
      return left(ServerFailure(e.toString(), statusCode: 500));
    }
  }
}
