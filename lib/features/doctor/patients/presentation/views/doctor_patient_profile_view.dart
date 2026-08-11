import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/di/injection.dart';
import 'package:ilajak/core/routing/route_names.dart';
import 'package:ilajak/core/shared/buttons/app_button.dart';
import 'package:ilajak/core/shared/feedback/app_error_widget.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/loading/app_loading.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/doctor/medical_records/logic/doctor_medical_records_cubit/doctor_medical_records_cubit.dart';
import 'package:ilajak/features/doctor/medical_records/logic/doctor_medical_records_cubit/doctor_medical_records_state.dart';
import 'package:ilajak/features/doctor/medical_records/presentation/widgets/medical_record_list_tile.dart';
import 'package:ilajak/features/doctor/patients/presentation/widgets/medical_condition_row.dart';
import 'package:ilajak/features/doctor/patients/presentation/widgets/medication_list_item.dart';
import 'package:ilajak/features/doctor/patients/presentation/widgets/patient_profile_header_card.dart';
import 'package:ilajak/features/doctor/patients/presentation/widgets/recent_visit_timeline_item.dart';
import 'package:ilajak/features/doctor/prescriptions/logic/doctor_prescriptions_cubit/doctor_prescriptions_cubit.dart';
import 'package:ilajak/features/doctor/prescriptions/logic/doctor_prescriptions_cubit/doctor_prescriptions_state.dart';
import 'package:ilajak/features/doctor/prescriptions/presentation/widgets/prescription_list_tile.dart';

/// Navigation payload for `RouteNames.doctorPatientProfileFullPath` and
/// `RouteNames.doctorPatientRecordsFullPath`.
///
/// SECURITY NOTE (IDOR): [patientId] must only ever be constructed from a
/// value the signed-in doctor is already allowed to see — today that
/// means `AppointmentModel.patientId` from `GET /appointments` (the
/// doctor's own appointments). Never construct this from a raw int typed
/// by the user, a route path parameter, or any other client-supplied
/// value. Whether the backend itself re-validates that this doctor is
/// actually allowed to read this patient's medical-records/prescriptions
/// is a separate, currently-unconfirmed backend concern — see the
/// "Backend gaps" note shipped alongside this feature. Flutter does not
/// (and cannot) enforce that authorization itself.
class DoctorPatientProfileArgs {
  const DoctorPatientProfileArgs({required this.patientId, this.patientName});

  final int patientId;
  final String? patientName;
}

/// Safe fallback shown by the router instead of `DoctorPatientProfileView`
/// / `DoctorPatientRecordsView` / `CreateMedicalRecordView` /
/// `CreatePrescriptionView` when `state.extra` is missing or not a valid
/// `DoctorPatientProfileArgs` (or `int` patientId, for the create screens).
///
/// Deliberately does NOT fall back to a placeholder/mock patient id — a
/// screen that reads another patient's medical records or prescriptions
/// must always be reached with a real id from a real appointment. Two
/// existing entry points in the app ("Recent Patients" on the Doctor Home,
/// and the "Patients" tab list) still push `doctorPatientProfileFullPath`
/// with no `extra` at all — they are mock/unwired screens with no patient
/// id to give (see backend gaps), so tapping them now lands here instead
/// of the old fake "James Wilson" profile.
class MissingPatientContextView extends StatelessWidget {
  const MissingPatientContextView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Scaffold(
        appBar: AppTopBar(
          leadingWidget: GestureDetector(
            onTap: () => context.pop(),
            child: Icon(Icons.arrow_back, color: AppColors.textPrimaryLight, size: 22.sp),
          ),
          titleWidget: Text(
            AppStrings.doctorPatientProfileTitle.tr(),
            style: AppTypography.semiBold18.copyWith(color: AppColors.textPrimaryLight),
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Text(
              AppStrings.doctorMissingPatientContext.tr(),
              textAlign: TextAlign.center,
              style: AppTypography.regular14.copyWith(color: AppColors.textSecondary),
            ),
          ),
        ),
      ),
    );
  }
}

/// TODO(backend): the demographic header (age/gender/blood type/phone/
/// email/address) and the "Medical Conditions" / "Active Medications" /
/// "Recent Visits" cards below are still fully hardcoded mock content —
/// out of scope for this pass (no Allergies/Chronic-Conditions/Personal-Info
/// doctor-facing endpoint exists yet; see backend gaps). Only the
/// "Medical Records" and "Prescriptions" sections below are wired to real
/// data.
class DoctorPatientProfileView extends StatefulWidget {
  const DoctorPatientProfileView({super.key, required this.patientId, this.patientName});

  final int patientId;
  final String? patientName;

  @override
  State<DoctorPatientProfileView> createState() => _DoctorPatientProfileViewState();
}

class _DoctorPatientProfileViewState extends State<DoctorPatientProfileView> {
  late final DoctorMedicalRecordsCubit _medicalRecordsCubit;
  late final DoctorPrescriptionsCubit _prescriptionsCubit;

  @override
  void initState() {
    super.initState();
    _medicalRecordsCubit = sl<DoctorMedicalRecordsCubit>()..loadRecords(patientId: widget.patientId);
    _prescriptionsCubit = sl<DoctorPrescriptionsCubit>()..loadPrescriptions(patientId: widget.patientId);
  }

  @override
  void dispose() {
    _medicalRecordsCubit.close();
    _prescriptionsCubit.close();
    super.dispose();
  }

  void _openRecords(BuildContext context) {
    context.push(
      RouteNames.doctorPatientRecordsFullPath,
      extra: DoctorPatientProfileArgs(patientId: widget.patientId, patientName: widget.patientName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _medicalRecordsCubit),
        BlocProvider.value(value: _prescriptionsCubit),
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Scaffold(
          appBar: AppTopBar(
            leadingWidget: GestureDetector(
              onTap: () => context.pop(),
              child: Icon(Icons.arrow_back, color: AppColors.textPrimaryLight, size: 22.sp),
            ),
            titleWidget: Text(
              AppStrings.doctorPatientProfileTitle.tr(),
              style: AppTypography.semiBold18.copyWith(color: AppColors.textPrimaryLight),
            ),
            actionWidget: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedSearch01,
                  size: 22.sp,
                  color: AppColors.textPrimaryLight,
                  strokeWidth: 1.5,
                ),
                SizedBox(width: 14.w),
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.primaryLight2,
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedHospital01,
                    size: 18.sp,
                    color: AppColors.primary,
                    strokeWidth: 1.5,
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  PatientProfileHeaderCard(
                    name: widget.patientName ??
                        '${AppStrings.doctorPatientRecordsPatientIdPrefix.tr()}${widget.patientId}',
                    // TODO(backend): no doctor-facing "get patient personal
                    // info" endpoint exists yet — see backend gaps.
                    ageLabel: '—',
                    genderLabel: '—',
                    bloodTypeLabel: AppStrings.doctorPatientProfileNoneReported.tr(),
                    phone: '—',
                    email: '—',
                    address: '—',
                  ),
                  SizedBox(height: 16.h),

                  _SectionCard(
                    icon: Icons.medical_information_outlined,
                    title: AppStrings.doctorPatientProfileMedicalConditions.tr(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MedicalConditionRow(
                          eyebrowLabel: AppStrings.doctorPatientProfileAllergies.tr(),
                          value: AppStrings.doctorPatientProfileNoneReported.tr(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          child: const Divider(height: 1, color: AppColors.divider),
                        ),
                        MedicalConditionRow(
                          eyebrowLabel: AppStrings.doctorPatientProfileChronicDiseases.tr(),
                          value: AppStrings.doctorPatientProfileNoneReported.tr(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  _SectionCard(
                    icon: Icons.medication_outlined,
                    title: AppStrings.doctorPatientProfileActiveMedications.tr(),
                    trailing: const _CountPill(count: 2),
                    child: Column(
                      children: [
                        const MedicationListItem(name: 'Lisinopril', detail: '10mg Oral Tablet • Once Daily'),
                        SizedBox(height: 10.h),
                        const MedicationListItem(name: 'Amlodipine', detail: '5mg Oral Tablet • Evening'),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  _SectionCard(
                    icon: Icons.history,
                    title: AppStrings.doctorPatientProfileRecentVisits.tr(),
                    child: Column(
                      children: [
                        const RecentVisitTimelineItem(
                          icon: Icons.calendar_today_outlined,
                          title: 'General Consultation',
                          dateAndBy: 'Oct 12, 2023 • Dr. Sarah Jenkins',
                          note: 'Patient reports stable BP readings over last 30 days.',
                        ),
                        RecentVisitTimelineItem(
                          icon: Icons.science_outlined,
                          title: 'Blood Work Analysis',
                          dateAndBy: 'Aug 05, 2023 • Central Lab',
                          pendingLabel: AppStrings.doctorPatientProfileResultsPending.tr(),
                        ),
                        const RecentVisitTimelineItem(
                          icon: Icons.monitor_heart_outlined,
                          title: 'Routine EKG',
                          dateAndBy: 'May 19, 2023 • Cardiac Center',
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // ── Real data starts here ─────────────────────────────
                  _SectionCard(
                    icon: Icons.folder_shared_outlined,
                    title: AppStrings.doctorMedicalRecordsTitle.tr(),
                    child: BlocBuilder<DoctorMedicalRecordsCubit, DoctorMedicalRecordsState>(
                      builder: (context, state) {
                        if (state is DoctorMedicalRecordsLoading || state is DoctorMedicalRecordsInitial) {
                          return const AppLoading();
                        }
                        if (state is DoctorMedicalRecordsError) {
                          return AppErrorWidget(
                            message: state.message,
                            onRetry: () => _medicalRecordsCubit.loadRecords(patientId: widget.patientId),
                          );
                        }
                        final records = state is DoctorMedicalRecordsLoaded ? state.records : const [];
                        if (records.isEmpty) {
                          return Text(
                            AppStrings.doctorMedicalRecordsEmpty.tr(),
                            style: AppTypography.regular14.copyWith(color: AppColors.textSecondary),
                          );
                        }
                        return Column(
                          children: [
                            for (final record in records.take(2)) ...[
                              MedicalRecordListTile(record: record),
                              SizedBox(height: 10.h),
                            ],
                            TextButton(
                              onPressed: () => _openRecords(context),
                              child: Text(AppStrings.doctorPatientProfileViewMedicalHistory.tr()),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),

                  _SectionCard(
                    icon: Icons.receipt_long_outlined,
                    title: AppStrings.doctorPrescriptionsSectionTitle.tr(),
                    child: BlocBuilder<DoctorPrescriptionsCubit, DoctorPrescriptionsState>(
                      builder: (context, state) {
                        if (state is DoctorPrescriptionsLoading || state is DoctorPrescriptionsInitial) {
                          return const AppLoading();
                        }
                        if (state is DoctorPrescriptionsError) {
                          return AppErrorWidget(
                            message: state.message,
                            onRetry: () =>
                                _prescriptionsCubit.loadPrescriptions(patientId: widget.patientId),
                          );
                        }
                        final prescriptions =
                            state is DoctorPrescriptionsLoaded ? state.prescriptions : const [];
                        if (prescriptions.isEmpty) {
                          return Text(
                            AppStrings.doctorPrescriptionsEmpty.tr(),
                            style: AppTypography.regular14.copyWith(color: AppColors.textSecondary),
                          );
                        }
                        return Column(
                          children: [
                            for (final prescription in prescriptions.take(2)) ...[
                              PrescriptionListTile(prescription: prescription),
                              SizedBox(height: 10.h),
                            ],
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),

                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          label: AppStrings.doctorPatientProfileAddPrescription.tr(),
                          variant: AppButtonVariant.elevated,
                          prefixIcon: Icon(Icons.add_box_outlined, size: 20.sp),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            textStyle: AppTypography.semiBold14,
                          ),
                          onPressed: () async {
                            final created = await context.push<bool>(
                              RouteNames.doctorAddPrescriptionFullPath,
                              extra: widget.patientId,
                            );
                            if (created == true) {
                              _prescriptionsCubit.loadPrescriptions(patientId: widget.patientId);
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: AppButton(
                          label: AppStrings.doctorPatientProfileBookFollowUp.tr(),
                          variant: AppButtonVariant.elevated,
                          prefixIcon: Icon(Icons.event_available_outlined, size: 20.sp),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            textStyle: AppTypography.semiBold14,
                          ),
                          // Out of scope for this task (see "no Appointment
                          // Creation" constraint) — left untouched.
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h + MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The recurring "white card, icon + title header, then content" shell
/// used by every card on this screen.
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.child,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20.sp, color: AppColors.textPrimaryLight),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.semiBold18.copyWith(color: AppColors.textPrimaryLight),
                ),
              ),
              ?trailing,
            ],
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }
}

class _CountPill extends StatelessWidget {
  const _CountPill({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        '$count ${AppStrings.doctorPatientProfileItemsSuffix.tr()}',
        style: AppTypography.semiBold14.copyWith(color: AppColors.primary),
      ),
    );
  }
}
