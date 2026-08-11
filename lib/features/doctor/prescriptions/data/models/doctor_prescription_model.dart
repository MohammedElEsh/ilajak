import 'package:equatable/equatable.dart';

/// Model for a single prescription as returned by
/// `GET /prescriptions?patient_id=` and `POST /prescriptions` (confirmed
/// against the "3ilajak Backend API v1" Postman collection).
///
/// NOTE: deliberately separate from any model under
/// `lib/features/patient/prescriptions/` — that folder's repository/model
/// were left untouched per an explicit scope decision (doctor-only work).
/// This is a standalone doctor-side model, not a shared one.
///
/// The backend merges the create-request fields (`medication_name`,
/// `dosage`, `instructions`) into a single `details` string in the
/// response — there is no `medication_name`/`dosage` breakdown on read,
/// so this model only stores `details` as returned.
class DoctorPrescriptionModel extends Equatable {
  final int? id;
  final int appointmentId;
  final int? patientId;
  final int? doctorId;
  final String details;
  final String? filePath;
  final String? doctorName;
  final String? createdAt;
  final String? updatedAt;

  const DoctorPrescriptionModel({
    this.id,
    required this.appointmentId,
    this.patientId,
    this.doctorId,
    required this.details,
    this.filePath,
    this.doctorName,
    this.createdAt,
    this.updatedAt,
  });

  factory DoctorPrescriptionModel.fromJson(Map<String, dynamic> json) {
    final doctor = json['doctor'];
    final doctorMap = doctor is Map<String, dynamic> ? doctor : null;
    final doctorUser = doctorMap?['user'];
    final doctorUserMap = doctorUser is Map<String, dynamic> ? doctorUser : null;

    return DoctorPrescriptionModel(
      id: json['id'] as int?,
      appointmentId: json['appointment_id'] as int,
      patientId: json['patient_id'] as int?,
      doctorId: json['doctor_id'] as int?,
      details: json['details'] as String? ?? '',
      filePath: json['file_path'] as String?,
      doctorName: doctorUserMap?['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  @override
  List<Object?> get props =>
      [id, appointmentId, patientId, doctorId, details, filePath, doctorName, createdAt, updatedAt];
}
