import 'package:equatable/equatable.dart';
import 'package:ilajak/features/doctor/medical_records/data/models/medical_record_model.dart';

class DoctorMedicalRecordsState extends Equatable {
  const DoctorMedicalRecordsState();

  @override
  List<Object?> get props => [];
}

class DoctorMedicalRecordsInitial extends DoctorMedicalRecordsState {
  const DoctorMedicalRecordsInitial();
}

class DoctorMedicalRecordsLoading extends DoctorMedicalRecordsState {
  const DoctorMedicalRecordsLoading();
}

class DoctorMedicalRecordsLoaded extends DoctorMedicalRecordsState {
  final List<MedicalRecordModel> records;

  const DoctorMedicalRecordsLoaded({required this.records});

  @override
  List<Object?> get props => [records];
}

class DoctorMedicalRecordsError extends DoctorMedicalRecordsState {
  final String message;

  const DoctorMedicalRecordsError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Submitting `POST /medical-records` from the Create Medical Record form.
/// Kept separate from [DoctorMedicalRecordsLoading] (list fetch) so the
/// list section and the create form don't fight over the same loading flag
/// when both are mounted (e.g. profile summary + create screen).
class DoctorMedicalRecordsCreating extends DoctorMedicalRecordsState {
  const DoctorMedicalRecordsCreating();
}

class DoctorMedicalRecordsCreateSuccess extends DoctorMedicalRecordsState {
  final MedicalRecordModel record;

  const DoctorMedicalRecordsCreateSuccess({required this.record});

  @override
  List<Object?> get props => [record];
}

class DoctorMedicalRecordsCreateError extends DoctorMedicalRecordsState {
  final String message;

  const DoctorMedicalRecordsCreateError({required this.message});

  @override
  List<Object?> get props => [message];
}
