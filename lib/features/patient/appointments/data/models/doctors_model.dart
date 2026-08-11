class DoctorModel {
  final int id;
  final String name;
  final String? avatar;
  final String specialization;
  final double consultationFee;
  final int clinicId;
  final String? clinicName;
  final String? clinicAddress;
  final double averageRating;
  final int reviews;
  final int experience;
  final int totalPatients;
  final String availability;

  DoctorModel({
    required this.id,
    required this.clinicId,
    required this.name,
    this.avatar,
    required this.specialization,
    required this.consultationFee,
    this.clinicName,
    this.clinicAddress,
    required this.averageRating,
    required this.reviews,
    required this.experience,
    required this.totalPatients,
    required this.availability,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? 0,
      name: json['user']?['name'] ?? '',
      avatar: json['user']?['avatar'],
      specialization: json['specialization'] ?? '',
      consultationFee:
          double.tryParse(json['consultation_fee']?.toString() ?? '') ?? 0,
      clinicName:
          (json['clinics'] is List && (json['clinics'] as List).isNotEmpty)
          ? json['clinics'][0]['name']
          : null,
      clinicAddress:
          (json['clinics'] is List && (json['clinics'] as List).isNotEmpty)
          ? json['clinics'][0]['address']
          : null,
      clinicId:
          (json['clinics'] is List && (json['clinics'] as List).isNotEmpty)
          ? json['clinics'][0]['id'] ?? 0
          : 0,
      averageRating:
          double.tryParse(json['average_rating']?.toString() ?? '') ?? 0,
      reviews: int.tryParse(json['total_ratings']?.toString() ?? '') ?? 0,
      experience: int.tryParse(json['experience']?.toString() ?? '') ?? 0,
      totalPatients:
          int.tryParse(json['total_patients']?.toString() ?? '') ?? 0,
      availability: json['availability']?.toString() ?? '',
    );
  }
}
