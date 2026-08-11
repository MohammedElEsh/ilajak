import 'package:ilajak/core/errors/failures.dart';
import 'package:ilajak/core/errors/safe_call.dart';
import 'package:ilajak/core/networking/api_consumer.dart';
import 'package:ilajak/core/networking/api_endpoints.dart';
import 'package:ilajak/features/doctor/prescriptions/data/models/doctor_prescription_model.dart';
import 'package:ilajak/features/doctor/prescriptions/domain/repositories/doctor_prescriptions_repository.dart';

class DoctorPrescriptionsRepositoryImpl implements DoctorPrescriptionsRepository {
  final ApiConsumer _apiConsumer;

  DoctorPrescriptionsRepositoryImpl({required ApiConsumer apiConsumer}) : _apiConsumer = apiConsumer;

  @override
  EitherResult<List<DoctorPrescriptionModel>> getPrescriptions({required int patientId}) {
    return safeCall(() async {
      final response = await _apiConsumer.get(
        ApiEndpoints.prescriptions,
        queryParameters: {'patient_id': patientId},
      );

      final list = response is Map<String, dynamic>
          ? response['data'] as List?
          : response is List
              ? response
              : null;

      if (list == null) {
        throw const ServerFailure('Unexpected response format');
      }

      return list
          .map((e) => DoctorPrescriptionModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  EitherResult<DoctorPrescriptionModel> createPrescription({
    required int appointmentId,
    required String medicationName,
    required String dosage,
    required String instructions,
  }) {
    return safeCall(() async {
      final response = await _apiConsumer.post(
        ApiEndpoints.prescriptions,
        data: {
          'appointment_id': appointmentId,
          'medication_name': medicationName,
          'dosage': dosage,
          'instructions': instructions,
        },
      );

      if (response is! Map<String, dynamic>) {
        throw const ServerFailure('Unexpected response format');
      }

      final map = response['data'] is Map<String, dynamic>
          ? response['data'] as Map<String, dynamic>
          : response;

      return DoctorPrescriptionModel.fromJson(map);
    });
  }
}
