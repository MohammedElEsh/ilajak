import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/buttons/app_button.dart';
import 'package:ilajak/core/shared/feedback/feedback_handler.dart';
import 'package:ilajak/core/shared/inputs/app_text_field.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/doctor/medical_records/data/models/medical_record_model.dart';
import 'package:ilajak/features/doctor/medical_records/logic/doctor_medical_records_cubit/doctor_medical_records_cubit.dart';
import 'package:ilajak/features/doctor/medical_records/logic/doctor_medical_records_cubit/doctor_medical_records_state.dart';

/// `POST /medical-records` form.
///
/// [patientId] must come from a real appointment (see
/// `DoctorPatientProfileArgs`) — this view never invents or falls back to
/// a placeholder id.
class CreateMedicalRecordView extends StatefulWidget {
  const CreateMedicalRecordView({super.key, required this.patientId});

  final int patientId;

  @override
  State<CreateMedicalRecordView> createState() => _CreateMedicalRecordViewState();
}

class _CreateMedicalRecordViewState extends State<CreateMedicalRecordView> {
  final _formKey = GlobalKey<FormState>();
  final _chronicDiseasesController = TextEditingController();
  final _allergiesController = TextEditingController();

  final List<_KeyValueRow> _labResultRows = [_KeyValueRow()];
  final List<_KeyValueRow> _radiologyResultRows = [_KeyValueRow()];
  final List<TextEditingController> _attachmentControllers = [TextEditingController()];

  @override
  void dispose() {
    _chronicDiseasesController.dispose();
    _allergiesController.dispose();
    for (final row in _labResultRows) row.dispose();
    for (final row in _radiologyResultRows) row.dispose();
    for (final c in _attachmentControllers) c.dispose();
    super.dispose();
  }

  Map<String, String> _collect(List<_KeyValueRow> rows) {
    final map = <String, String>{};
    for (final row in rows) {
      final key = row.keyController.text.trim();
      final value = row.valueController.text.trim();
      if (key.isNotEmpty && value.isNotEmpty) map[key] = value;
    }
    return map;
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final record = MedicalRecordModel(
      patientId: widget.patientId,
      chronicDiseases:
          _chronicDiseasesController.text.trim().isEmpty ? null : _chronicDiseasesController.text.trim(),
      allergies: _allergiesController.text.trim().isEmpty ? null : _allergiesController.text.trim(),
      labResults: _collect(_labResultRows),
      radiologyResults: _collect(_radiologyResultRows),
      attachments: _attachmentControllers
          .map((c) => c.text.trim())
          .where((s) => s.isNotEmpty)
          .toList(),
    );

    context.read<DoctorMedicalRecordsCubit>().createRecord(record);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Scaffold(
        appBar: AppTopBar(
          leadingWidget: GestureDetector(
            onTap: () => context.pop(),
            child: Icon(Icons.arrow_back, color: context.appColors.primary, size: 22.sp),
          ),
          titleWidget: Text(
            AppStrings.doctorCreateMedicalRecordTitle.tr(),
            style: AppTypography.semiBold18.copyWith(color: context.appColors.primary),
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<DoctorMedicalRecordsCubit, DoctorMedicalRecordsState>(
            listener: (context, state) {
              if (state is DoctorMedicalRecordsCreateError) {
                FeedbackHandler.error(state.message);
              }
              if (state is DoctorMedicalRecordsCreateSuccess) {
                FeedbackHandler.success(AppStrings.doctorCreateMedicalRecordSuccess.tr());
                context.pop(true);
              }
            },
            builder: (context, state) {
              final isSubmitting = state is DoctorMedicalRecordsCreating;

              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      _FieldLabel(AppStrings.doctorMedicalRecordsChronicDiseases.tr()),
                      SizedBox(height: 8.h),
                      AppTextField(
                        controller: _chronicDiseasesController,
                        hint: AppStrings.doctorCreateMedicalRecordChronicHint.tr(),
                        maxLines: 2,
                      ),
                      SizedBox(height: 20.h),

                      _FieldLabel(AppStrings.doctorMedicalRecordsAllergies.tr()),
                      SizedBox(height: 8.h),
                      AppTextField(
                        controller: _allergiesController,
                        hint: AppStrings.doctorCreateMedicalRecordAllergiesHint.tr(),
                        maxLines: 2,
                      ),
                      SizedBox(height: 24.h),

                      _SectionHeader(
                        title: AppStrings.doctorMedicalRecordsLabResults.tr(),
                        onAdd: () => setState(() => _labResultRows.add(_KeyValueRow())),
                      ),
                      SizedBox(height: 8.h),
                      for (int i = 0; i < _labResultRows.length; i++)
                        _KeyValueInputRow(
                          row: _labResultRows[i],
                          onRemove: _labResultRows.length > 1
                              ? () => setState(() {
                                    _labResultRows[i].dispose();
                                    _labResultRows.removeAt(i);
                                  })
                              : null,
                        ),
                      SizedBox(height: 24.h),

                      _SectionHeader(
                        title: AppStrings.doctorMedicalRecordsRadiologyResults.tr(),
                        onAdd: () => setState(() => _radiologyResultRows.add(_KeyValueRow())),
                      ),
                      SizedBox(height: 8.h),
                      for (int i = 0; i < _radiologyResultRows.length; i++)
                        _KeyValueInputRow(
                          row: _radiologyResultRows[i],
                          onRemove: _radiologyResultRows.length > 1
                              ? () => setState(() {
                                    _radiologyResultRows[i].dispose();
                                    _radiologyResultRows.removeAt(i);
                                  })
                              : null,
                        ),
                      SizedBox(height: 24.h),

                      _SectionHeader(
                        title: AppStrings.doctorMedicalRecordsAttachments.tr(),
                        onAdd: () => setState(() => _attachmentControllers.add(TextEditingController())),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        AppStrings.doctorCreateMedicalRecordAttachmentsHint.tr(),
                        style: AppTypography.regular12.copyWith(color: context.appColors.textSecondary),
                      ),
                      SizedBox(height: 8.h),
                      for (int i = 0; i < _attachmentControllers.length; i++)
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  controller: _attachmentControllers[i],
                                  hint: AppStrings.doctorCreateMedicalRecordAttachmentHint.tr(),
                                ),
                              ),
                              if (_attachmentControllers.length > 1)
                                IconButton(
                                  onPressed: () => setState(() {
                                    _attachmentControllers[i].dispose();
                                    _attachmentControllers.removeAt(i);
                                  }),
                                  icon: Icon(Icons.remove_circle_outline, color: context.appColors.error),
                                ),
                            ],
                          ),
                        ),
                      SizedBox(height: 24.h),

                      AppButton(
                        variant: AppButtonVariant.elevated,
                        label: AppStrings.doctorCreateMedicalRecordSave.tr(),
                        onPressed: _onSubmit,
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
}

class _KeyValueRow {
  final TextEditingController keyController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  void dispose() {
    keyController.dispose();
    valueController.dispose();
  }
}

class _KeyValueInputRow extends StatelessWidget {
  const _KeyValueInputRow({required this.row, this.onRemove});

  final _KeyValueRow row;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: AppTextField(
              controller: row.keyController,
              hint: AppStrings.doctorCreateMedicalRecordFieldNameHint.tr(),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 3,
            child: AppTextField(
              controller: row.valueController,
              hint: AppStrings.doctorCreateMedicalRecordFieldValueHint.tr(),
            ),
          ),
          if (onRemove != null)
            IconButton(
              onPressed: onRemove,
              icon: Icon(Icons.remove_circle_outline, color: context.appColors.error),
            ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onAdd});

  final String title;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTypography.semiBold16.copyWith(color: context.appColors.textPrimary),
          ),
        ),
        IconButton(
          onPressed: onAdd,
          icon: Icon(Icons.add_circle_outline, color: context.appColors.primary),
        ),
      ],
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
      style: AppTypography.medium14.copyWith(color: context.appColors.textPrimary),
    );
  }
}
