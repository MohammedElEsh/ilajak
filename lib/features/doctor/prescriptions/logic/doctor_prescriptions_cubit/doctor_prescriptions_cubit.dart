import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilajak/features/doctor/prescriptions/domain/repositories/doctor_prescriptions_repository.dart';

import 'doctor_prescriptions_state.dart';

class DoctorPrescriptionsCubit extends Cubit<DoctorPrescriptionsState> {
  final DoctorPrescriptionsRepository _repository;

  DoctorPrescriptionsCubit(this._repository) : super(const DoctorPrescriptionsInitial());

  /// [patientId] must come from a real appointment — see the IDOR note in
  /// `DoctorPatientProfileArgs`.
  Future<void> loadPrescriptions({required int patientId}) async {
    emit(const DoctorPrescriptionsLoading());
    final result = await _repository.getPrescriptions(patientId: patientId);
    result.fold(
      (failure) => emit(DoctorPrescriptionsError(message: failure.message)),
      (prescriptions) => emit(DoctorPrescriptionsLoaded(prescriptions: prescriptions)),
    );
  }

  Future<void> createPrescription({
    required int appointmentId,
    required String medicationName,
    required String dosage,
    required String instructions,
  }) async {
    emit(const DoctorPrescriptionsCreating());
    final result = await _repository.createPrescription(
      appointmentId: appointmentId,
      medicationName: medicationName,
      dosage: dosage,
      instructions: instructions,
    );
    result.fold(
      (failure) => emit(DoctorPrescriptionsCreateError(message: failure.message)),
      (created) => emit(DoctorPrescriptionsCreateSuccess(prescription: created)),
    );
  }
}
