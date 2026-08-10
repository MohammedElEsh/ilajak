import 'package:equatable/equatable.dart';

class DoctorRegisterState extends Equatable {
  const DoctorRegisterState();

  @override
  List<Object?> get props => [];
}

class DoctorRegisterInitial extends DoctorRegisterState {
  const DoctorRegisterInitial();
}

class DoctorRegisterLoading extends DoctorRegisterState {
  const DoctorRegisterLoading();
}

class DoctorRegisterSuccess extends DoctorRegisterState {
  const DoctorRegisterSuccess();
}

class DoctorRegisterError extends DoctorRegisterState {
  final String message;

  const DoctorRegisterError({required this.message});

  @override
  List<Object?> get props => [message];
}
