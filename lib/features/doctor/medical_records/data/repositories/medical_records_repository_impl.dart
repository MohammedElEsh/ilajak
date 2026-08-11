import 'package:ilajak/core/errors/failures.dart';
import 'package:ilajak/core/errors/safe_call.dart';
import 'package:ilajak/core/networking/api_consumer.dart';
import 'package:ilajak/core/networking/api_endpoints.dart';
import 'package:ilajak/features/doctor/medical_records/data/models/medical_record_model.dart';
import 'package:ilajak/features/doctor/medical_records/domain/repositories/medical_records_repository.dart';

class MedicalRecordsRepositoryImpl implements MedicalRecordsRepository {
  final ApiConsumer _apiConsumer;

  MedicalRecordsRepositoryImpl({required ApiConsumer apiConsumer}) : _apiConsumer = apiConsumer;

  @override
  EitherResult<List<MedicalRecordModel>> getMedicalRecords({required int patientId}) {
    return safeCall(() async {
      final response = await _apiConsumer.get(
        ApiEndpoints.medicalRecords,
        queryParameters: {'patient_id': patientId},
      );

      // Confirmed shape: `{ "status": "success", "data": [...] }`.
      final list = response is Map<String, dynamic>
          ? response['data'] as List?
          : response is List
              ? response
              : null;

      if (list == null) {
        throw const ServerFailure('Unexpected response format');
      }

      return list
          .map((e) => MedicalRecordModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  EitherResult<MedicalRecordModel> createMedicalRecord(MedicalRecordModel record) {
    return safeCall(() async {
      final response = await _apiConsumer.post(
        ApiEndpoints.medicalRecords,
        data: record.toCreateJson(),
      );

      if (response is! Map<String, dynamic>) {
        throw const ServerFailure('Unexpected response format');
      }

      final map = response['data'] is Map<String, dynamic>
          ? response['data'] as Map<String, dynamic>
          : response;

      return MedicalRecordModel.fromJson(map);
    });
  }
}
