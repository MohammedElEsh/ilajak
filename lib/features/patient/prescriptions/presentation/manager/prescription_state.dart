import 'package:equatable/equatable.dart';

import '../../data/models/prescription_model.dart';

class PrescriptionState extends Equatable {
  const PrescriptionState();

  @override
  List<Object?> get props => [];
}

class PrescriptionInitial extends PrescriptionState {
  const PrescriptionInitial();
}

class PrescriptionLoading extends PrescriptionState {
  const PrescriptionLoading();
}

class PrescriptionSuccess extends PrescriptionState {
  final List<PrescriptionModel> prescriptions;

  const PrescriptionSuccess({required this.prescriptions});

  @override
  List<Object?> get props => [prescriptions];
}

class PrescriptionError extends PrescriptionState {
  final String message;

  const PrescriptionError({required this.message});

  @override
  List<Object?> get props => [message];
}
