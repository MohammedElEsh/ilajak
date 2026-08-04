import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/routing/route_names.dart';
import 'package:ilajak/core/shared/buttons/app_button.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/layout/bottom_nav_clearance.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/doctor/patients/presentation/widgets/medical_condition_row.dart';
import 'package:ilajak/features/doctor/patients/presentation/widgets/medication_list_item.dart';
import 'package:ilajak/features/doctor/patients/presentation/widgets/patient_profile_header_card.dart';
import 'package:ilajak/features/doctor/patients/presentation/widgets/recent_visit_timeline_item.dart';

// TODO(backend): fully hardcoded (James Wilson, from the mock) — swap for
// the real doctor-patient-profile cubit, fetched by patient id, once the
// API/integration work starts. Every card in this file follows the same
// "PatientListCard tapped -> push here" flow regardless of which patient
// was tapped, for now.
class DoctorPatientProfileView extends StatelessWidget {
  const DoctorPatientProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Scaffold(
        appBar: AppTopBar(
          leadingWidget: GestureDetector(
            onTap: () => context.pop(),
            child: Icon(Icons.arrow_back, color: context.appColors.textPrimary, size: 22.sp),
          ),
          titleWidget: Text(
            AppStrings.doctorPatientProfileTitle.tr(),
            style: AppTypography.semiBold18.copyWith(color: context.appColors.textPrimary),
          ),
          actionWidget: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedSearch01,
                size: 22.sp,
                color: context.appColors.textPrimary,
                strokeWidth: 1.5,
              ),
              SizedBox(width: 14.w),
              CircleAvatar(
                radius: 18.r,
                backgroundColor: context.appColors.primaryLight2,
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedHospital01,
                  size: 18.sp,
                  color: context.appColors.primary,
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
                const PatientProfileHeaderCard(
                  name: 'James Wilson',
                  ageLabel: '45 Years',
                  genderLabel: 'Male',
                  bloodTypeLabel: 'Blood Type: O+',
                  phone: '+1 (555) 012-3456',
                  email: 'j.wilson@example.com',
                  address: '742 Evergreen Terrace, Springfield, IL 62704',
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
                        child: Divider(height: 1, color: context.appColors.divider),
                      ),
                      MedicalConditionRow(
                        eyebrowLabel: AppStrings.doctorPatientProfileChronicDiseases.tr(),
                        value: 'Hypertension (Controlled)',
                        isFlagged: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                _SectionCard(
                  icon: Icons.medication_outlined,
                  title: AppStrings.doctorPatientProfileActiveMedications.tr(),
                  trailing: _CountPill(count: 2),
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
                      RecentVisitTimelineItem(
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
                      RecentVisitTimelineItem(
                        icon: Icons.monitor_heart_outlined,
                        title: 'Routine EKG',
                        dateAndBy: 'May 19, 2023 • Cardiac Center',
                        isLast: true,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () => context.push(RouteNames.doctorPatientRecordsFullPath),
                    child: Text(
                      AppStrings.doctorPatientProfileViewMedicalHistory.tr(),
                      style: AppTypography.semiBold14.copyWith(color: context.appColors.primary),
                    ),
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
                        // NOTE: the global elevatedButtonTheme (light_theme.dart /
                        // dark_theme.dart) uses 24px padding + a semiBold20 text
                        // style — sized for a single full-width CTA, not a tight
                        // two-up row like this. Overriding both here so the pair
                        // reads as compact pill buttons like the mock.
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          textStyle: AppTypography.semiBold14,
                        ),
                        onPressed: () {},
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
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h + context.bottomNavClearance),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The recurring "white card, icon + title header, then content" shell
/// used by the Medical Conditions / Active Medications / Recent Visits
/// cards on this screen.
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
        color: context.appColors.surface,
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
              Icon(icon, size: 20.sp, color: context.appColors.textPrimary),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.semiBold18.copyWith(color: context.appColors.textPrimary),
                ),
              ),
              if (trailing != null) trailing!,
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
        color: context.appColors.secondary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        '$count ${AppStrings.doctorPatientProfileItemsSuffix.tr()}',
        style: AppTypography.semiBold14.copyWith(color: context.appColors.primary),
      ),
    );
  }
}
