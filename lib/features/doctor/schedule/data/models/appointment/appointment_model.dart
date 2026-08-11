import 'package:equatable/equatable.dart';

/// Model for a single appointment as returned by `GET /appointments`
/// (used for the doctor's own schedule) and mutated via
/// `PATCH /appointments/{id}/status`.
///
/// NOTE: the Postman collection has no saved example response for either
/// endpoint, so the field names below are a best-effort guess based on
/// REST convention + the PATCH body we DO have (`{"status": "confirmed"}`).
/// `fromJson` defensively checks a couple of likely key variants for the
/// patient name/id so a small naming mismatch doesn't break parsing —
/// but please confirm against a real response and simplify once you have
/// one.
class AppointmentModel extends Equatable {
  final int id;
  final int? patientId;
  final String patientName;

  /// e.g. "Consultation", "Follow-up", "Check-up"
  final String? type;

  /// Raw date/time string from the API — kept as-is; format for display
  /// with DateFormatter at the call site rather than here.
  final String? date;
  final String? time;

  /// e.g. "pending", "confirmed", "completed", "cancelled"
  final String status;

  const AppointmentModel({
    required this.id,
    this.patientId,
    required this.patientName,
    this.type,
    this.date,
    this.time,
    required this.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    final patient = json['patient'];
    final patientMap = patient is Map<String, dynamic> ? patient : null;

    return AppointmentModel(
      id: json['id'] as int,
      patientId: patientMap?['id'] as int? ?? json['patient_id'] as int?,
      patientName: (patientMap?['name'] as String?) ??
          (json['patient_name'] as String?) ??
          'Unknown',
      type: json['type'] as String? ?? json['appointment_type'] as String?,
      date: json['date'] as String? ?? json['appointment_date'] as String?,
      time: json['time'] as String? ?? json['appointment_time'] as String?,
      status: json['status'] as String? ?? 'pending',
    );
  }

  bool get isConfirmed => status == 'confirmed';
  bool get isPending => status == 'pending';
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';

  @override
  List<Object?> get props => [id, patientId, patientName, type, date, time, status];
}
