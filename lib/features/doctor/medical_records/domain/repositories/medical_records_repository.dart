import 'package:ilajak/core/errors/safe_call.dart';
import 'package:ilajak/features/doctor/medical_records/data/models/medical_record_model.dart';

abstract class MedicalRecordsRepository {
  /// `GET /medical-records?patient_id={patientId}` — confirmed in the
  /// Postman collection. Always scope by patient — never call this
  /// without a `patientId` (see IDOR note in the Cubit).
  EitherResult<List<MedicalRecordModel>> getMedicalRecords({
    required int patientId,
  });

  /// `POST /medical-records` — body per the collection's saved example:
  /// `patient_id`, `chronic_diseases`, `allergies`, `lab_results` (object),
  /// `radiology_results` (object), `attachments` (array of strings).
  EitherResult<MedicalRecordModel> createMedicalRecord(MedicalRecordModel record);
}
