import 'package:equatable/equatable.dart';

class DoctorProfileModel extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? status;
  final String? avatarUrl;
  final String? specialization;
  final String? licenseNumber;
  final String? bio;
  final List<dynamic> clinics;

  const DoctorProfileModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.status,
    this.avatarUrl,
    this.specialization,
    this.licenseNumber,
    this.bio,
    this.clinics = const [],
  });

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    return DoctorProfileModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      status: json['status'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      specialization: json['specialization'] as String?,
      licenseNumber: json['license_number'] as String?,
      bio: json['bio'] as String?,
      clinics: json['clinics'] is List ? json['clinics'] as List : const [],
    );
  }

  DoctorProfileModel copyWith({String? avatarUrl}) {
    return DoctorProfileModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      status: status,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      specialization: specialization,
      licenseNumber: licenseNumber,
      bio: bio,
      clinics: clinics,
    );
  }

  /// First assigned clinic's name, if any.
  ///
  /// NOTE: every "GET Doctor" example in the Postman collection returns
  /// `clinics: []`, so this is untested against real populated data — I
  /// don't actually know the shape of a populated clinic entry yet.
  /// Flagged in chat; the "Clinic" field on the profile screen will just
  /// show '—' until we confirm it.
  String? get firstClinicName {
    if (clinics.isEmpty) return null;
    final first = clinics.first;
    if (first is Map<String, dynamic>) return first['name'] as String?;
    return null;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        status,
        avatarUrl,
        specialization,
        licenseNumber,
        bio,
        clinics,
      ];
}
