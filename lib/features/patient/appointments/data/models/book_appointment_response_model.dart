class BookAppointmentResponseModel {
  final int id;
  final int patientId;
  final int doctorId;
  final int clinicId;
  final String date;
  final String slotTime;
  final String status;
  final String createdAt;
  final String updatedAt;

  BookAppointmentResponseModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.clinicId,
    required this.date,
    required this.slotTime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookAppointmentResponseModel.fromJson(Map<String, dynamic> json) {
    return BookAppointmentResponseModel(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      patientId: int.tryParse(json['patient_id']?.toString() ?? '') ?? 0,
      doctorId: int.tryParse(json['doctor_id']?.toString() ?? '') ?? 0,
      clinicId: int.tryParse(json['clinic_id']?.toString() ?? '') ?? 0,
      date: json['date']?.toString() ?? '',
      slotTime: json['slot_time']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }
}
