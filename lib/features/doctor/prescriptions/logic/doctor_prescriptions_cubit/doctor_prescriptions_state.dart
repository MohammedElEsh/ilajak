import 'package:equatable/equatable.dart';
import 'package:ilajak/features/doctor/prescriptions/data/models/doctor_prescription_model.dart';

class DoctorPrescriptionsState extends Equatable {
  const DoctorPrescriptionsState();

  @override
  List<Object?> get props => [];
}

class DoctorPrescriptionsInitial extends DoctorPrescriptionsState {
  const DoctorPrescriptionsInitial();
}

class DoctorPrescriptionsLoading extends DoctorPrescriptionsState {
  const DoctorPrescriptionsLoading();
}

class DoctorPrescriptionsLoaded extends DoctorPrescriptionsState {
  final List<DoctorPrescriptionModel> prescriptions;

  const DoctorPrescriptionsLoaded({required this.prescriptions});

  @override
  List<Object?> get props => [prescriptions];
}

class DoctorPrescriptionsError extends DoctorPrescriptionsState {
  final String message;

  const DoctorPrescriptionsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class DoctorPrescriptionsCreating extends DoctorPrescriptionsState {
  const DoctorPrescriptionsCreating();
}

class DoctorPrescriptionsCreateSuccess extends DoctorPrescriptionsState {
  final DoctorPrescriptionModel prescription;

  const DoctorPrescriptionsCreateSuccess({required this.prescription});

  @override
  List<Object?> get props => [prescription];
}

class DoctorPrescriptionsCreateError extends DoctorPrescriptionsState {
  final String message;

  const DoctorPrescriptionsCreateError({required this.message});

  @override
  List<Object?> get props => [message];
}
