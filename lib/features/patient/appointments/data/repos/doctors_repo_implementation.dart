
import 'package:fpdart/fpdart.dart';
import 'package:ilajak/core/errors/failures.dart';
import 'package:ilajak/core/networking/api_consumer.dart';
import 'package:ilajak/core/networking/api_endpoints.dart';
import 'package:ilajak/features/patient/appointments/data/models/doctors_details_model.dart';
import 'package:ilajak/features/patient/appointments/data/models/doctors_model.dart';
import 'package:ilajak/features/patient/appointments/data/repos/doctors_repo.dart';

class DoctorsRepoImplementation implements DoctorsRepo {
  final ApiConsumer apiConsumer;

  DoctorsRepoImplementation(this.apiConsumer);

  @override
  Future<Either<Failure, List<DoctorModel>>> getAllDoctors() async {
    try {
      final response = await apiConsumer.get(ApiEndpoints.doctors);
      final List<DoctorModel> doctors = [];
      final doctorsList = response['data']['data'] as List<dynamic>;
      for (var doctor in doctorsList) {
        doctors.add(DoctorModel.fromJson(doctor));
      }
      return right(doctors);
    } catch (e) {
      return left(
        ServerFailure(
          e.toString(),
          statusCode: 500,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, DoctorDetailsModel>> getSingleDoctorDetails(int doctorId) async {
    try {
      final response = await apiConsumer.get(ApiEndpoints.singleDoctor(doctorId));
      final doctor = DoctorDetailsModel.fromJson(response['data']);
      return right(doctor);
    } catch (e) {
      return left(
        ServerFailure(
          e.toString(),
          statusCode: 500,
        ),
      );
    }
  }
}
