class BookAppointmentRequest {
  final int doctorId;
  final int clinicId;
  final String date;
  final String slotTime;

  BookAppointmentRequest({
    required this.doctorId,
    required this.clinicId,
    required this.date,
    required this.slotTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'doctor_id': doctorId,
      'clinic_id': clinicId,
      'date': date,
      'slot_time': slotTime,
    };
  }
}
