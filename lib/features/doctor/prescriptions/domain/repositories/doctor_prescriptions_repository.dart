import 'package:ilajak/core/errors/safe_call.dart';
import 'package:ilajak/features/doctor/prescriptions/data/models/doctor_prescription_model.dart';

abstract class DoctorPrescriptionsRepository {
  /// `GET /prescriptions?patient_id={patientId}` — confirmed in the
  /// Postman collection. Always scope by patient.
  EitherResult<List<DoctorPrescriptionModel>> getPrescriptions({
    required int patientId,
  });

  /// `POST /prescriptions` — body: `appointment_id`, `medication_name`,
  /// `dosage`, `instructions` (per the collection's saved example).
  EitherResult<DoctorPrescriptionModel> createPrescription({
    required int appointmentId,
    required String medicationName,
    required String dosage,
    required String instructions,
  });
}
