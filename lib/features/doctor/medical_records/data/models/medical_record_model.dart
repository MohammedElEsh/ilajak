import 'package:equatable/equatable.dart';

/// Model for a single medical record as returned by
/// `GET /medical-records?patient_id=` and `POST /medical-records`
/// (confirmed against the "3ilajak Backend API v1" Postman collection —
/// the "Medical Records & Prescriptions" folder).
///
/// `lab_results` and `radiology_results` are free-form key/value objects
/// in the real response (e.g. `{"blood_pressure": "130/85"}`) — kept as
/// `Map<String, String>` rather than a fixed set of fields since the
/// backend doesn't document a closed schema for them.
class MedicalRecordModel extends Equatable {
  final int? id;
  final int patientId;
  final String? chronicDiseases;
  final String? allergies;
  final Map<String, String> labResults;
  final Map<String, String> radiologyResults;
  final List<String> attachments;
  final String? createdAt;
  final String? updatedAt;

  const MedicalRecordModel({
    this.id,
    required this.patientId,
    this.chronicDiseases,
    this.allergies,
    this.labResults = const {},
    this.radiologyResults = const {},
    this.attachments = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) {
    return MedicalRecordModel(
      id: json['id'] as int?,
      patientId: json['patient_id'] as int,
      chronicDiseases: json['chronic_diseases'] as String?,
      allergies: json['allergies'] as String?,
      labResults: _asStringMap(json['lab_results']),
      radiologyResults: _asStringMap(json['radiology_results']),
      // The backend returns `attachments: null` for older records — never
      // assume it's always a list.
      attachments: (json['attachments'] as List?)?.map((e) => e.toString()).toList() ??
          const [],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  /// Body for `POST /medical-records`. `attachments` stays a plain list of
  /// filename strings — the collection's current contract has no real
  /// multipart file upload for this endpoint.
  Map<String, dynamic> toCreateJson() {
    return {
      'patient_id': patientId,
      if (chronicDiseases != null) 'chronic_diseases': chronicDiseases,
      if (allergies != null) 'allergies': allergies,
      if (labResults.isNotEmpty) 'lab_results': labResults,
      if (radiologyResults.isNotEmpty) 'radiology_results': radiologyResults,
      if (attachments.isNotEmpty) 'attachments': attachments,
    };
  }

  static Map<String, String> _asStringMap(dynamic value) {
    if (value is Map) {
      return value.map((key, v) => MapEntry(key.toString(), v.toString()));
    }
    return const {};
  }

  bool get hasLabResults => labResults.isNotEmpty;
  bool get hasRadiologyResults => radiologyResults.isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        patientId,
        chronicDiseases,
        allergies,
        labResults,
        radiologyResults,
        attachments,
        createdAt,
        updatedAt,
      ];
}
