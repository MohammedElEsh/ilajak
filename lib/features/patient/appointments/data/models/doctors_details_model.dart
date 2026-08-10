class DoctorDetailsModel {
  final String name;
  final String specialization;
  final String bio;
  final String email;
  final String phone;
  final String consultationFee;
  final List<ClinicModel> clinics;
  final List<ScheduleModel> schedules;

  DoctorDetailsModel({
    required this.name,
    required this.specialization,
    required this.bio,
    required this.email,
    required this.phone,
    required this.consultationFee,
    required this.clinics,
    required this.schedules,
  });

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    return DoctorDetailsModel(
      name: json['user']?['name']?.toString() ?? 'Unknown Name',
      specialization: json['specialization']?.toString() ?? 'General',
      bio: json['bio']?.toString() ?? 'No biography available.',
      email: json['user']?['email']?.toString() ?? 'No email',
      phone: json['user']?['phone']?.toString() ?? 'No phone',
      consultationFee: json['consultation_fee']?.toString() ?? '0.00',
      clinics: (json['clinics'] as List?)
              ?.map((e) => ClinicModel.fromJson(e))
              .toList() ??
          [],
      schedules: (json['schedules'] as List?)
              ?.map((e) => ScheduleModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ClinicModel {
  final String name;
  final String address;
  final String phone;

  ClinicModel({
    required this.name,
    required this.address,
    required this.phone,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return ClinicModel(
      name: json['name']?.toString() ?? 'Unknown Clinic',
      address: json['address']?.toString() ?? 'No address',
      phone: json['phone']?.toString() ?? 'No phone',
    );
  }
}

class ScheduleModel {
  final String dayOfWeek;

  ScheduleModel({
    required this.dayOfWeek,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      dayOfWeek: json['day_of_week']?.toString() ?? 'Unknown Day',
    );
  }
}