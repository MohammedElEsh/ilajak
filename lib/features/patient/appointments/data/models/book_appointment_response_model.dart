class BookAppointmentResponseModel {
  final int patientId;
  final int doctorId;
  final int clinicId;
  final String date;
  final String slotTime;
  final String status;
  final String updatedAt;
  final String createdAt;
  final int id;

  BookAppointmentResponseModel({
    required this.patientId,
    required this.doctorId,
    required this.clinicId,
    required this.date,
    required this.slotTime,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory BookAppointmentResponseModel.fromJson(Map<String, dynamic> json) {
    return BookAppointmentResponseModel(
      patientId: json['patient_id'],
      doctorId: json['doctor_id'],
      clinicId: json['clinic_id'],
      date: json['date'],
      slotTime: json['slot_time'],
      status: json['status'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }
}