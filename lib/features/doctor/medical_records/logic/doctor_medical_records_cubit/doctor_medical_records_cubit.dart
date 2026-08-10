import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilajak/features/doctor/medical_records/data/models/medical_record_model.dart';
import 'package:ilajak/features/doctor/medical_records/domain/repositories/medical_records_repository.dart';

import 'doctor_medical_records_state.dart';

class DoctorMedicalRecordsCubit extends Cubit<DoctorMedicalRecordsState> {
  final MedicalRecordsRepository _repository;

  DoctorMedicalRecordsCubit(this._repository) : super(const DoctorMedicalRecordsInitial());

  /// [patientId] must always come from a real source (an appointment the
  /// signed-in doctor already has for this patient) — never a
  /// client-trusted value typed in or guessed. See `DoctorPatientProfileArgs`
  /// at the call site.
  Future<void> loadRecords({required int patientId}) async {
    emit(const DoctorMedicalRecordsLoading());
    final result = await _repository.getMedicalRecords(patientId: patientId);
    result.fold(
      (failure) => emit(DoctorMedicalRecordsError(message: failure.message)),
      (records) => emit(DoctorMedicalRecordsLoaded(records: records)),
    );
  }

  Future<void> createRecord(MedicalRecordModel record) async {
    emit(const DoctorMedicalRecordsCreating());
    final result = await _repository.createMedicalRecord(record);
    result.fold(
      (failure) => emit(DoctorMedicalRecordsCreateError(message: failure.message)),
      (created) => emit(DoctorMedicalRecordsCreateSuccess(record: created)),
    );
  }
}
