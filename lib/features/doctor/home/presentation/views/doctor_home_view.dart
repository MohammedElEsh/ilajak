import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/formatters/date_formatter.dart';
import 'package:ilajak/core/routing/route_names.dart';
import 'package:ilajak/core/shared/buttons/app_button.dart';
import 'package:ilajak/core/shared/inputs/search_field.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/layout/bottom_nav_clearance.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/doctor/home/presentation/widgets/doctor_appointment_card.dart';
import 'package:ilajak/features/doctor/home/presentation/widgets/doctor_stat_card.dart';
import 'package:ilajak/features/doctor/home/presentation/widgets/recent_patient_avatar.dart';

// TODO(backend): everything below is placeholder data — swap for the real
// doctor/dashboard cubit once the API + integration work starts. Kept as a
// plain StatelessWidget for now, same as PatientHomeView.
class DoctorHomeView extends StatelessWidget {
  const DoctorHomeView({super.key});

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
          actionWidget: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedSearch01,
                size: 24.sp,
                color: context.appColors.primary,
                strokeWidth: 1.5,
              ),
              SizedBox(width: 16.w),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedNotification01,
                    size: 24.sp,
                    color: context.appColors.primary,
                    strokeWidth: 1.5,
                  ),
                  Positioned(
                    top: -2.h,
                    right: -2.w,
                    child: Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: context.appColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                Text(
                  '${AppStrings.doctorHomeGreeting.tr()}, Dr. Sarah',
                  style: AppTypography.semiBold20.copyWith(color: context.appColors.textPrimary),
                ),
                SizedBox(height: 8.h),
                Text(
                  DateFormatter.formatToWeekdayDate(DateTime.now()),
                  style: AppTypography.regular14.copyWith(color: context.appColors.textSecondary),
                ),
                SizedBox(height: 24.h),

                SearchField(onChanged: (_) {}),
                SizedBox(height: 24.h),

                // ── Stats grid ─────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: DoctorStatCard(
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedCalendar02,
                          size: 24.sp,
                          color: context.appColors.surface,
                          strokeWidth: 1.5,
                        ),
                        value: '12',
                        label: AppStrings.doctorHomeAppointmentsToday.tr(),
                        badgeText: AppStrings.doctorHomeTodayBadge.tr(),
                        backgroundColor: context.appColors.primary,
                        onTap: () => context.push(RouteNames.doctorScheduleFullPath),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: DoctorStatCard(
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedClock01,
                          size: 24.sp,
                          color: context.appColors.primary,
                          strokeWidth: 1.5,
                        ),
                        value: '03',
                        label: AppStrings.doctorHomePending.tr(),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: DoctorStatCard(
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedCheckmarkCircle02,
                          size: 24.sp,
                          color: context.appColors.primary,
                          strokeWidth: 1.5,
                        ),
                        value: '08',
                        label: AppStrings.doctorHomeCompleted.tr(),
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: DoctorStatCard(
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedUserAdd01,
                          size: 24.sp,
                          color: context.appColors.surface,
                          strokeWidth: 1.5,
                        ),
                        value: '02',
                        label: AppStrings.doctorHomeNewPatients.tr(),
                        backgroundColor: context.appColors.primaryLight,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                // ── Quick actions ──────────────────────────────────────
                Text(
                  AppStrings.doctorHomeQuickActions.tr(),
                  style: AppTypography.semiBold16.copyWith(color: context.appColors.textPrimary),
                ),
                SizedBox(height: 16.h),
                LayoutBuilder(
                 builder: (context, constraints) {
                   final isNarrow = constraints.maxWidth < 400;
                   if (isNarrow) {
                     return Column(
                       crossAxisAlignment: CrossAxisAlignment.stretch,
                       children: [
                         AppButton(
                           label: AppStrings.doctorHomeAddAppointment.tr(),
                           variant: AppButtonVariant.elevated,
                           prefixIcon: SizedBox(width: 20.w, height: 20.h, child: Center(child: Icon(Icons.add, size: 18.sp))),
                           style: ElevatedButton.styleFrom(
                             padding: EdgeInsets.symmetric(vertical: 16.h),
                             textStyle: AppTypography.semiBold14,
                           ),
                           onPressed: () {},
                         ),
                         SizedBox(height: 12.h),
                         AppButton(
                           label: AppStrings.doctorHomeRecordVisit.tr(),
                           variant: AppButtonVariant.elevated,
                           prefixIcon: SizedBox(width: 20.w, height: 20.h, child: Center(child: HugeIcon(
                             icon: HugeIcons.strokeRoundedNoteEdit,
                             size: 18.sp,
                             color: context.appColors.primary,
                           ))),
                           style: ElevatedButton.styleFrom(
                             backgroundColor: context.appColors.primaryLight2,
                             foregroundColor: context.appColors.primary,
                             elevation: 0,
                             padding: EdgeInsets.symmetric(vertical: 16.h),
                             textStyle: AppTypography.semiBold14,
                           ),
                           onPressed: () {},
                         ),
                       ],
                     );
                   }

                   return Row(
                     children: [
                       Expanded(
                         child: AppButton(
                           label: AppStrings.doctorHomeAddAppointment.tr(),
                           variant: AppButtonVariant.elevated,
                           prefixIcon: SizedBox(width: 20.w, height: 20.h, child: Center(child: Icon(Icons.add, size: 18.sp))),
                           style: ElevatedButton.styleFrom(
                             padding: EdgeInsets.symmetric(vertical: 16.h),
                             textStyle: AppTypography.semiBold14,
                           ),
                           onPressed: () {},
                         ),
                       ),
                       SizedBox(width: 12.w),
                       Expanded(
                         child: AppButton(
                           label: AppStrings.doctorHomeRecordVisit.tr(),
                           variant: AppButtonVariant.elevated,
                           prefixIcon: SizedBox(width: 20.w, height: 20.h, child: Center(child: HugeIcon(
                             icon: HugeIcons.strokeRoundedNoteEdit,
                             size: 18.sp,
                             color: context.appColors.primary,
                           ))),
                           style: ElevatedButton.styleFrom(
                             backgroundColor: context.appColors.primaryLight2,
                             foregroundColor: context.appColors.primary,
                             elevation: 0,
                             padding: EdgeInsets.symmetric(vertical: 16.h),
                             textStyle: AppTypography.semiBold14,
                           ),
                           onPressed: () {},
                         ),
                       ),
                     ],
                   );
                 },
                ),
                SizedBox(height: 32.h),

                // ── Recent patients ────────────────────────────────────
                Row(
                  children: [
                    Text(
                      AppStrings.doctorHomeRecentPatients.tr(),
                      style: AppTypography.semiBold16.copyWith(color: context.appColors.textPrimary),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => context.go(RouteNames.doctorPatients),
                      child: Text(
                        AppStrings.doctorHomeViewAll.tr(),
                        style: AppTypography.regular14.copyWith(color: context.appColors.primary),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 92.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _recentPatients.length,
                    separatorBuilder: (_, __) => SizedBox(width: 16.w),
                    itemBuilder: (context, index) {
                      final name = _recentPatients[index];
                      return RecentPatientAvatar(
                        name: name,
                        highlighted: index == 0,
                        onTap: () => context.push(RouteNames.doctorPatientProfileFullPath),
                      );
                    },
                  ),
                ),
                SizedBox(height: 32.h),

                // ── Upcoming today ─────────────────────────────────────
                Row(
                  children: [
                    Text(
                      AppStrings.doctorHomeUpcomingToday.tr(),
                      style: AppTypography.semiBold16.copyWith(color: context.appColors.textPrimary),
                    ),
                    const Spacer(),
                    Text(
                      '${DateFormatter.formatToTime(DateTime.now())} • ${AppStrings.doctorHomeNowLabel.tr()}',
                      style: AppTypography.semiBold14.copyWith(color: context.appColors.primary),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                const DoctorAppointmentCard(
                  patientName: 'Robert Wilson',
                  timeLabel: '10:30 AM • Follow-up',
                  room: 'ROOM 402',
                ),
                SizedBox(height: 12.h),
                const DoctorAppointmentCard(
                  patientName: 'Linda Chen',
                  timeLabel: '10:00 AM • Initial Consult',
                  room: 'ROOM 105',
                  isLive: true,
                ),
                SizedBox(height: 12.h),
                const DoctorAppointmentCard(
                  patientName: 'Marcus Thorne',
                  timeLabel: '11:15 AM • Annual Checkup',
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

const _recentPatients = ['James R.', 'Sarah W.', 'Michael K.', 'Eleanor P.'];
