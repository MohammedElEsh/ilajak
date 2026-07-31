import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/prescription_model.dart';
import 'prescription_state.dart';

class PrescriptionCubit extends Cubit<PrescriptionState> {
  PrescriptionCubit() : super(const PrescriptionInitial());

  List<PrescriptionModel> _allPrescriptions = [];

  Future<void> getPrescriptions() async {
    emit(const PrescriptionLoading());
    await Future.delayed(const Duration(seconds: 1));

    _allPrescriptions = const [
      PrescriptionModel(
        id: 1,
        doctorName: 'Dr. Sarah Johnson',
        clinicName: 'General Health Clinic',
        medicinesCount: 3,
        datePrescribed: 'Oct 24, 2023',
        status: 'active',
      ),

      PrescriptionModel(
        id: 2,
        doctorName: 'Dr. Emily Chen',
        clinicName: 'Dermatology Clinic',
        medicinesCount: 1,
        datePrescribed: 'Dec 10, 2023',
        status: 'completed',
      ),
      PrescriptionModel(
        id: 3,
        doctorName: 'Dr. Michael Brown',
        clinicName: 'Diabetes Care Center',
        medicinesCount: 4,
        datePrescribed: 'Mar 1, 2024',
        status: 'expiring_soon',
      ),

      PrescriptionModel(
        id: 4,
        doctorName: 'Dr. Sarah Johnson',
        clinicName: 'General Health Clinic',
        medicinesCount: 2,
        datePrescribed: 'Nov 20, 2023',
        status: 'expired',
      ),
    ];

    emit(PrescriptionSuccess(prescriptions: _allPrescriptions));
  }

  void filterByStatus(String status) {
    if (state is PrescriptionSuccess) {
      if (status == 'all') {
        emit(PrescriptionSuccess(prescriptions: _allPrescriptions));
      } else {
        final filtered = _allPrescriptions
            .where((p) => p.status == status)
            .toList();
        emit(PrescriptionSuccess(prescriptions: filtered));
      }
    }
  }
}
