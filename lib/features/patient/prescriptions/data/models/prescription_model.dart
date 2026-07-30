import 'package:equatable/equatable.dart';

class PrescriptionModel extends Equatable {
  final int id;
  final String doctorName;
  final String clinicName;
  final int medicinesCount;
  final String datePrescribed;
  final String status;

  const PrescriptionModel({
    required this.id,
    required this.doctorName,
    required this.clinicName,
    required this.medicinesCount,
    required this.datePrescribed,
    required this.status,
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      id: json['id'] as int,
      doctorName: json['doctor_name'] as String,
      clinicName: json['clinic_name'] as String,
      medicinesCount: json['medicines_count'] as int,
      datePrescribed: json['date_prescribed'] as String,
      status: json['status'] as String,
    );
  }

  @override
  List<Object?> get props => [
        id,
        doctorName,
        clinicName,
        medicinesCount,
        datePrescribed,
        status,
      ];
}
