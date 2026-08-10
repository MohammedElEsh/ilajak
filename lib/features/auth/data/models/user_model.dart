import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? avatar;
  final String? role;
  final String? phone;
  final String? nationalId;
  final String? status;
  final String? gender;
  final String? dob;
  final String? address;
  final String? bloodType;

  const UserModel({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.role,
    this.phone,
    this.nationalId,
    this.status,
    this.gender,
    this.dob,
    this.address,
    this.bloodType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      role: json['role'] as String?,
      phone: json['phone'] as String?,
      nationalId: json['national_id'] as String?,
      status: json['status'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      address: json['address'] as String?,
      bloodType: json['blood_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'role': role,
      'phone': phone,
      'national_id': nationalId,
      'status': status,
      'gender': gender,
      'dob': dob,
      'address': address,
      'blood_type': bloodType,
    };
  }

  @override
  List<Object?> get props =>
      [id, name, email, avatar, role, phone, nationalId, status, gender, dob, address, bloodType];
}
