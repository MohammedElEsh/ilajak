import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/chips/app_filter_chip.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/layout/bottom_nav_clearance.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/doctor/patients/presentation/widgets/medical_record_card.dart';

// TODO(backend): hardcoded for James Wilson, from the mock — swap for the
// real doctor-patient-records cubit, fetched by patient id, once the
// API/integration work starts.
class DoctorPatientRecordsView extends StatefulWidget {
  const DoctorPatientRecordsView({super.key});

  @override
  State<DoctorPatientRecordsView> createState() => _DoctorPatientRecordsViewState();
}

class _DoctorPatientRecordsViewState extends State<DoctorPatientRecordsView> {
  static const _filterKeys = [
    AppStrings.doctorPatientRecordsFilterAll,
    AppStrings.doctorPatientRecordsFilterLabResults,
    AppStrings.doctorPatientRecordsFilterRadiology,
    AppStrings.doctorPatientRecordsFilterPrescriptions,
  ];

  int _selectedFilterIndex = 0;

  // NOTE: this used to be a top-level `final _records = [...]` list. It had
  // to move inside the State (as a method that takes context) once these
  // entries started reading `context.appColors.xxx` for dark-mode support —
  // a top-level variable has no BuildContext to read from.
  List<_MedicalRecordItem> _buildRecords(BuildContext context) {
    return [
      _MedicalRecordItem(
        badge: Icon(Icons.medical_services_outlined, color: context.appColors.surface, size: 20.sp),
        badgeColor: context.appColors.primary,
        date: 'Oct 12, 2023',
        title: 'Seasonal Allergies',
        doctorName: 'Dr. Mitchell',
        specialty: 'General Practitioner',
      ),
      _MedicalRecordItem(
        badge: Icon(Icons.history, color: context.appColors.surface, size: 20.sp),
        badgeColor: context.appColors.grey4,
        date: 'Aug 05, 2023',
        title: 'Routine Annual Checkup',
        doctorName: 'Dr. Mitchell',
        specialty: 'General Practitioner',
      ),
      _MedicalRecordItem(
        badge: Text(
          '*',
          style: TextStyle(
            color: context.appColors.surface,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        badgeColor: context.appColors.error,
        date: 'Jan 22, 2023',
        title: 'Acute Gastritis',
        doctorName: 'Dr. Sarah Chen',
        specialty: 'Gastroenterology',
        isFlagged: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final records = _buildRecords(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Scaffold(
        appBar: AppTopBar(
          leadingWidget: CircleAvatar(
            radius: 20.r,
            backgroundColor: context.appColors.primaryLight2,
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedHospital01,
              size: 20.sp,
              color: context.appColors.primary,
              strokeWidth: 1.5,
            ),
          ),
          titleWidget: Text(
            AppStrings.doctorHomeAppBarTitle.tr(),
            style: AppTypography.semiBold18.copyWith(color: context.appColors.primary),
          ),
          actionWidget: HugeIcon(
            icon: HugeIcons.strokeRoundedSearch01,
            size: 24.sp,
            color: context.appColors.primary,
            strokeWidth: 1.5,
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(
                          width: 64.w,
                          height: 64.h,
                          color: context.appColors.secondary,
                          child: Icon(Icons.person_outline, color: context.appColors.primary, size: 30.sp),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'James Wilson',
                              style: AppTypography.semiBold22.copyWith(color: context.appColors.textPrimary),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '${AppStrings.doctorPatientRecordsPatientIdPrefix.tr()}#JW-8829 • Male, 42',
                              style: AppTypography.regular14.copyWith(color: context.appColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  SizedBox(
                    height: 40.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filterKeys.length,
                      separatorBuilder: (_, __) => SizedBox(width: 10.w),
                      itemBuilder: (context, index) {
                        return AppFilterChip(
                          label: _filterKeys[index].tr(),
                          selected: index == _selectedFilterIndex,
                          onTap: () => setState(() => _selectedFilterIndex = index),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),

                  Expanded(
                    child: ListView.separated(
                      itemCount: records.length,
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      // Leave room so the last card isn't hidden behind
                      // the FAB / the overlay bottom nav bar.
                      padding: EdgeInsets.only(bottom: 90.h + context.bottomNavClearance),
                      itemBuilder: (context, index) {
                        final record = records[index];
                        return MedicalRecordCard(
                          badge: record.badge,
                          badgeColor: record.badgeColor,
                          date: record.date,
                          title: record.title,
                          doctorName: record.doctorName,
                          specialty: record.specialty,
                          isFlagged: record.isFlagged,
                        );
                      },
                    ),
                  ),
                ],
              ),
              // NOTE: positioned manually because RouterShell draws the
              // BottomNavBar as an overlay, not Scaffold.bottomNavigationBar.
              Positioned(
                right: 0,
                bottom: 16.h + context.bottomNavClearance,
                child: FloatingActionButton(
                  onPressed: () {
                    // TODO(backend): open the "Add Record" creation flow.
                  },
                  backgroundColor: context.appColors.primary,
                  child: Icon(Icons.add, color: context.appColors.surface, size: 26.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MedicalRecordItem {
  const _MedicalRecordItem({
    required this.badge,
    required this.badgeColor,
    required this.date,
    required this.title,
    required this.doctorName,
    required this.specialty,
    this.isFlagged = false,
  });

  final Widget badge;
  final Color badgeColor;
  final String date;
  final String title;
  final String doctorName;
  final String specialty;
  final bool isFlagged;
}
