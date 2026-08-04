import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/routing/route_names.dart';
import 'package:ilajak/core/shared/chips/app_filter_chip.dart';
import 'package:ilajak/core/shared/inputs/search_field.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/layout/bottom_nav_clearance.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/doctor/patients/presentation/widgets/patient_list_card.dart';

// TODO(backend): placeholder patient list — swap for the real
// doctor-patients cubit once the API/integration work starts.
class DoctorPatientsView extends StatefulWidget {
  const DoctorPatientsView({super.key});

  @override
  State<DoctorPatientsView> createState() => _DoctorPatientsViewState();
}

class _DoctorPatientsViewState extends State<DoctorPatientsView> {
  static const _filterKeys = [
    AppStrings.doctorPatientsFilterAll,
    AppStrings.doctorPatientsFilterToday,
    AppStrings.doctorPatientsFilterNew,
    AppStrings.doctorPatientsFilterReturning,
  ];

  int _selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    AppStrings.doctorPatientsTitle.tr(),
                    style: AppTypography.bold28.copyWith(color: context.appColors.textPrimary),
                  ),
                  SizedBox(height: 16.h),
                  SearchField(
                    hint: AppStrings.doctorPatientsSearchHint.tr(),
                    onChanged: (_) {},
                  ),
                  SizedBox(height: 16.h),
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
                      itemCount: _patients.length,
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      // Leave room at the bottom so the last card isn't
                      // hidden behind the FAB / the overlay bottom nav bar.
                      padding: EdgeInsets.only(bottom: 90.h + context.bottomNavClearance),
                      itemBuilder: (context, index) {
                        final patient = _patients[index];
                        return PatientListCard(
                          name: patient.name,
                          subtitle: patient.subtitle,
                          statusLabel: patient.isActive
                              ? AppStrings.doctorPatientsStatusActive.tr()
                              : AppStrings.doctorPatientsStatusPending.tr(),
                          isActive: patient.isActive,
                          lastVisitLabel: AppStrings.doctorPatientsLastVisit.tr(),
                          lastVisit: patient.lastVisit,
                          nextAppointmentLabel:
                              AppStrings.doctorPatientsNextAppointment.tr(),
                          nextAppointment: patient.isNextAppointmentScheduled
                              ? patient.nextAppointment
                              : AppStrings.doctorPatientsNotScheduled.tr(),
                          isNextAppointmentScheduled: patient.isNextAppointmentScheduled,
                          onTap: () => context.push(RouteNames.doctorPatientProfileFullPath),
                        );
                      },
                    ),
                  ),
                ],
              ),
              // NOTE: positioned manually (instead of Scaffold.floatingActionButton)
              // because RouterShell draws the BottomNavBar as an overlay, not a
              // proper Scaffold.bottomNavigationBar — see bottom_nav_clearance.dart.
              Positioned(
                right: 0,
                bottom: 16.h + context.bottomNavClearance,
                child: FloatingActionButton(
                  onPressed: () {
                    // TODO(backend): open the "Add Patient" creation flow.
                  },
                  backgroundColor: context.appColors.primary,
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedUserAdd01,
                    color: context.appColors.surface,
                    size: 24.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PatientListItem {
  const _PatientListItem({
    required this.name,
    required this.subtitle,
    required this.lastVisit,
    required this.nextAppointment,
    this.isActive = true,
    this.isNextAppointmentScheduled = true,
  });

  final String name;
  final String subtitle;
  final String lastVisit;
  final String nextAppointment;
  final bool isActive;
  final bool isNextAppointmentScheduled;
}

const _patients = [
  _PatientListItem(
    name: 'Emma Thompson',
    subtitle: '28, Female',
    lastVisit: 'Oct 12, 2023',
    nextAppointment: 'Tomorrow, 10:30 AM',
  ),
  _PatientListItem(
    name: 'Arthur Miller',
    subtitle: '72, Male',
    lastVisit: 'Nov 05, 2023',
    nextAppointment: 'Nov 22, 09:00 AM',
  ),
  _PatientListItem(
    name: 'Sarah Jenkins',
    subtitle: '45, Female',
    lastVisit: 'Aug 19, 2023',
    nextAppointment: '',
    isActive: false,
    isNextAppointmentScheduled: false,
  ),
];
