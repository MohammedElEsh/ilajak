import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/di/injection.dart';
import 'package:ilajak/core/shared/buttons/app_button.dart';
import 'package:ilajak/core/shared/feedback/feedback_handler.dart';
import 'package:ilajak/core/shared/inputs/app_text_field.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/doctor/prescriptions/logic/doctor_prescriptions_cubit/doctor_prescriptions_cubit.dart';
import 'package:ilajak/features/doctor/prescriptions/logic/doctor_prescriptions_cubit/doctor_prescriptions_state.dart';
import 'package:ilajak/features/doctor/schedule/data/models/appointment/appointment_model.dart';
import 'package:ilajak/features/doctor/schedule/domain/repositories/appointments_repository.dart';

/// `POST /prescriptions` form.
///
/// ASSUMPTION (flagged to the team): the create-prescription API requires
/// an `appointment_id`, but navigation into this screen only carries a
/// `patientId` (see `DoctorPatientProfileArgs`) — there's no
/// "list appointments for this patient" endpoint, so instead of inventing
/// one, this screen reuses the EXISTING `GET /appointments`
/// (`AppointmentsRepository`, already wired for the Schedule tab) and
/// filters client-side by `patientId` to build the appointment picker
/// below. If the backend later adds a dedicated appointment_id (or a
/// patient-scoped appointments endpoint), swap the source here.
class CreatePrescriptionView extends StatefulWidget {
  const CreatePrescriptionView({super.key, required this.patientId});

  final int patientId;

  @override
  State<CreatePrescriptionView> createState() => _CreatePrescriptionViewState();
}

class _CreatePrescriptionViewState extends State<CreatePrescriptionView> {
  final _formKey = GlobalKey<FormState>();
  final _medicationController = TextEditingController();
  final _dosageController = TextEditingController();
  final _instructionsController = TextEditingController();

  bool _loadingAppointments = true;
  String? _appointmentsError;
  List<AppointmentModel> _patientAppointments = const [];
  AppointmentModel? _selectedAppointment;

  @override
  void initState() {
    super.initState();
    _loadPatientAppointments();
  }

  Future<void> _loadPatientAppointments() async {
    setState(() {
      _loadingAppointments = true;
      _appointmentsError = null;
    });

    final result = await sl<AppointmentsRepository>().getMyAppointments();
    if (!mounted) return;

    result.fold(
      (failure) => setState(() {
        _loadingAppointments = false;
        _appointmentsError = failure.message;
      }),
      (appointments) => setState(() {
        _loadingAppointments = false;
        _patientAppointments =
            appointments.where((a) => a.patientId == widget.patientId).toList();
      }),
    );
  }

  @override
  void dispose() {
    _medicationController.dispose();
    _dosageController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    final appointment = _selectedAppointment;
    if (appointment == null) {
      FeedbackHandler.error(AppStrings.doctorCreatePrescriptionSelectAppointmentError.tr());
      return;
    }

    context.read<DoctorPrescriptionsCubit>().createPrescription(
          appointmentId: appointment.id,
          medicationName: _medicationController.text.trim(),
          dosage: _dosageController.text.trim(),
          instructions: _instructionsController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Scaffold(
        appBar: AppTopBar(
          leadingWidget: GestureDetector(
            onTap: () => context.pop(),
            child: Icon(Icons.arrow_back, color: AppColors.primary, size: 22.sp),
          ),
          titleWidget: Text(
            AppStrings.doctorCreatePrescriptionTitle.tr(),
            style: AppTypography.semiBold18.copyWith(color: AppColors.primary),
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<DoctorPrescriptionsCubit, DoctorPrescriptionsState>(
            listener: (context, state) {
              if (state is DoctorPrescriptionsCreateError) {
                FeedbackHandler.error(state.message);
              }
              if (state is DoctorPrescriptionsCreateSuccess) {
                FeedbackHandler.success(AppStrings.doctorCreatePrescriptionSuccess.tr());
                context.pop(true);
              }
            },
            builder: (context, state) {
              final isSubmitting = state is DoctorPrescriptionsCreating;

              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      _FieldLabel(AppStrings.doctorCreatePrescriptionAppointment.tr()),
                      SizedBox(height: 8.h),
                      _buildAppointmentPicker(context),
                      SizedBox(height: 20.h),

                      _FieldLabel(AppStrings.doctorCreatePrescriptionMedication.tr()),
                      SizedBox(height: 8.h),
                      AppTextField(
                        controller: _medicationController,
                        hint: AppStrings.doctorCreatePrescriptionMedicationHint.tr(),
                        validator: (value) => (value == null || value.trim().isEmpty)
                            ? AppStrings.doctorCreatePrescriptionRequiredField.tr()
                            : null,
                      ),
                      SizedBox(height: 20.h),

                      _FieldLabel(AppStrings.doctorCreatePrescriptionDosage.tr()),
                      SizedBox(height: 8.h),
                      AppTextField(
                        controller: _dosageController,
                        hint: AppStrings.doctorCreatePrescriptionDosageHint.tr(),
                        validator: (value) => (value == null || value.trim().isEmpty)
                            ? AppStrings.doctorCreatePrescriptionRequiredField.tr()
                            : null,
                      ),
                      SizedBox(height: 20.h),

                      _FieldLabel(AppStrings.doctorCreatePrescriptionInstructions.tr()),
                      SizedBox(height: 8.h),
                      AppTextField(
                        controller: _instructionsController,
                        hint: AppStrings.doctorCreatePrescriptionInstructionsHint.tr(),
                        maxLines: 3,
                        validator: (value) => (value == null || value.trim().isEmpty)
                            ? AppStrings.doctorCreatePrescriptionRequiredField.tr()
                            : null,
                      ),
                      SizedBox(height: 24.h),

                      AppButton(
                        variant: AppButtonVariant.elevated,
                        label: AppStrings.doctorCreatePrescriptionSave.tr(),
                        onPressed: (_loadingAppointments || _patientAppointments.isEmpty) ? null : _onSubmit,
                        isLoading: isSubmitting,
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentPicker(BuildContext context) {
    if (_loadingAppointments) {
      return SizedBox(
        height: 48.h,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_appointmentsError != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _appointmentsError!,
            style: AppTypography.regular14.copyWith(color: AppColors.error),
          ),
          TextButton(
            onPressed: _loadPatientAppointments,
            child: Text(AppStrings.sharedRetry.tr()),
          ),
        ],
      );
    }

    if (_patientAppointments.isEmpty) {
      return Text(
        AppStrings.doctorCreatePrescriptionNoAppointments.tr(),
        style: AppTypography.regular14.copyWith(color: AppColors.textSecondary),
      );
    }

    return DropdownButtonFormField<AppointmentModel>(
      initialValue: _selectedAppointment,
      items: [
        for (final appt in _patientAppointments)
          DropdownMenuItem(
            value: appt,
            child: Text('${appt.date ?? ''} ${appt.time ?? ''} — ${appt.type ?? ''}'.trim()),
          ),
      ],
      onChanged: (value) => setState(() => _selectedAppointment = value),
      decoration: InputDecoration(
        hintText: AppStrings.doctorCreatePrescriptionSelectAppointmentHint.tr(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTypography.medium14.copyWith(color: AppColors.textPrimaryLight),
    );
  }
}
