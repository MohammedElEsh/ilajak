class ProfileModel {
  final String name;
  final String email;
  final String? avatar;
  final int upcomingAppointments;
  final int prescriptions;
  final int medicalRecords;

  ProfileModel({
    required this.name,
    required this.email,
    this.avatar,
    required this.upcomingAppointments,
    required this.prescriptions,
    required this.medicalRecords,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      avatar: json['avatar'] as String?,
      upcomingAppointments:
          (json['upcoming_appointments'] as num?)?.toInt() ?? 0,
      prescriptions: (json['prescriptions'] as num?)?.toInt() ?? 0,
      medicalRecords: (json['medical_records'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'avatar': avatar,
      'upcoming_appointments': upcomingAppointments,
      'prescriptions': prescriptions,
      'medical_records': medicalRecords,
    };
  }
}