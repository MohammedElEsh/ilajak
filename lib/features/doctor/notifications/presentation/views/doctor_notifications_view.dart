import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/chips/app_filter_chip.dart';
import 'package:ilajak/core/shared/inputs/search_field.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/layout/bottom_nav_clearance.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/doctor/notifications/presentation/widgets/notification_card.dart';

// TODO(backend): placeholder notifications, synthesized from a few mock
// variants — swap for the real doctor-notifications cubit once the
// API/integration work starts. Filter chips are tappable but don't
// actually filter the list yet (same TODO pattern as Schedule/Patients).
class DoctorNotificationsView extends StatefulWidget {
  const DoctorNotificationsView({super.key});

  @override
  State<DoctorNotificationsView> createState() => _DoctorNotificationsViewState();
}

class _DoctorNotificationsViewState extends State<DoctorNotificationsView> {
  static const _filterKeys = [
    AppStrings.doctorNotificationsFilterAll,
    AppStrings.doctorNotificationsFilterUnread,
    AppStrings.doctorNotificationsFilterAppointments,
    AppStrings.doctorNotificationsFilterPatients,
  ];

  int _selectedFilterIndex = 0;

  TextStyle get _boldSpan =>
      AppTypography.semiBold14.copyWith(color: context.appColors.textPrimary);
  TextStyle get _urgentSpan =>
      AppTypography.semiBold14.copyWith(color: context.appColors.error);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Scaffold(
        appBar: AppTopBar(
          leadingWidget: GestureDetector(
            onTap: () {
              // TODO(design): same open-a-Drawer TODO as Doctor Profile.
            },
            child: Icon(Icons.menu, color: context.appColors.primary, size: 24.sp),
          ),
          titleWidget: Text(
            AppStrings.doctorNotificationsTitle.tr(),
            style: AppTypography.semiBold18.copyWith(color: context.appColors.primary),
          ),
          actionWidget: TextButton(
            onPressed: () {
              // TODO(backend): mark all notifications read.
            },
            child: Text(
              AppStrings.doctorNotificationsMarkAllRead.tr(),
              style: AppTypography.semiBold14.copyWith(color: context.appColors.primary),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              SearchField(
                hint: AppStrings.doctorNotificationsSearchHint.tr(),
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
                child: ListView(
                  padding: EdgeInsets.only(bottom: 24.h + context.bottomNavClearance),
                  children: [
                    _SectionHeader(AppStrings.doctorNotificationsSectionToday.tr()),
                    SizedBox(height: 10.h),
                    NotificationCard(
                      badge: HugeIcon(
                        icon: HugeIcons.strokeRoundedCalendar02,
                        color: context.appColors.surface,
                        size: 20.sp,
                      ),
                      badgeColor: context.appColors.primary,
                      title: 'New Appointment',
                      timestamp: 'Just now',
                      isUnread: true,
                      description: TextSpan(children: [
                        TextSpan(text: 'James Wilson', style: _boldSpan),
                        const TextSpan(text: ' booked a consultation for 2:30 PM today.'),
                      ]),
                      actions: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.appColors.primary,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          ),
                          child: Text(
                            AppStrings.doctorScheduleViewDetails.tr(),
                            style: AppTypography.semiBold14.copyWith(color: context.appColors.surface),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: context.appColors.primary),
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          ),
                          child: Text(
                            AppStrings.doctorNotificationsAccept.tr(),
                            style: AppTypography.semiBold14.copyWith(color: context.appColors.primary),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    NotificationCard(
                      badge: Icon(Icons.science_outlined, color: context.appColors.error, size: 20.sp),
                      badgeColor: context.appColors.error.withValues(alpha: .12),
                      title: 'Lab Result Ready',
                      timestamp: '45m ago',
                      isUnread: true,
                      description: TextSpan(children: [
                        const TextSpan(text: 'CBC results uploaded for '),
                        TextSpan(text: 'Sarah Chen', style: _boldSpan),
                        const TextSpan(text: '. '),
                        TextSpan(text: 'Urgent review recommended.', style: _urgentSpan),
                      ]),
                      actions: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.appColors.primary,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          ),
                          child: Text(
                            AppStrings.doctorNotificationsOpenLabs.tr(),
                            style: AppTypography.semiBold14.copyWith(color: context.appColors.surface),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    NotificationCard(
                      badge: Icon(Icons.event_busy_outlined, color: context.appColors.error, size: 20.sp),
                      badgeColor: context.appColors.error.withValues(alpha: .12),
                      backgroundColor: context.appColors.textSecondary.withValues(alpha: .06),
                      title: 'Appointment Cancelled',
                      timestamp: '2 hours ago',
                      description: TextSpan(children: [
                        TextSpan(text: 'Michael Rodriguez', style: _boldSpan),
                        const TextSpan(text: ' cancelled his '),
                        TextSpan(text: '4:00 PM slot', style: _urgentSpan),
                        const TextSpan(text: '. The slot is now available for other patients.'),
                      ]),
                    ),
                    SizedBox(height: 20.h),

                    _SectionHeader(AppStrings.doctorNotificationsSectionYesterday.tr()),
                    SizedBox(height: 10.h),
                    NotificationCard(
                      badge: HugeIcon(
                        icon: HugeIcons.strokeRoundedUserAdd01,
                        color: context.appColors.surface,
                        size: 20.sp,
                      ),
                      badgeColor: context.appColors.primaryLight,
                      title: 'New Patient Assigned',
                      timestamp: 'Yesterday, 9:15 AM',
                      description: TextSpan(children: [
                        TextSpan(text: 'Sarah Chen', style: _boldSpan),
                        const TextSpan(text: ' has been added to your care list. Review her initial screening.'),
                      ]),
                    ),
                    SizedBox(height: 12.h),
                    NotificationCard(
                      badge: Icon(Icons.history, color: context.appColors.primary, size: 20.sp),
                      badgeColor: context.appColors.primaryLight2,
                      title: 'Rescheduled',
                      timestamp: 'Yesterday, 8:30 AM',
                      description: TextSpan(children: [
                        TextSpan(text: 'Dr. Elena Vance', style: _boldSpan),
                        const TextSpan(text: ' moved the recurring weekly review to 11:30 AM.'),
                      ]),
                    ),
                    SizedBox(height: 12.h),
                    NotificationCard(
                      badge: Icon(Icons.medication_outlined, color: context.appColors.textSecondary, size: 20.sp),
                      badgeColor: context.appColors.divider,
                      title: 'Prescription Updated',
                      timestamp: 'Yesterday',
                      description: TextSpan(children: [
                        const TextSpan(text: 'Lisinopril dose adjusted for '),
                        TextSpan(text: 'Michael Rodriguez', style: _boldSpan),
                        const TextSpan(text: ' from 10mg to 20mg.'),
                      ]),
                    ),
                    SizedBox(height: 20.h),

                    _SectionHeader(AppStrings.doctorNotificationsSectionEarlier.tr()),
                    SizedBox(height: 10.h),
                    NotificationCard(
                      badge: Icon(Icons.description_outlined, color: context.appColors.textSecondary, size: 20.sp),
                      badgeColor: context.appColors.divider,
                      title: 'New Medical Article',
                      timestamp: '2 days ago',
                      description: const TextSpan(
                        text: 'Latest Clinical Guidelines for Hypertension: 2024 Updates for '
                            'Primary Care Physicians.',
                      ),
                    ),
                    SizedBox(height: 12.h),
                    NotificationCard(
                      badge: Icon(Icons.warning_amber_rounded, color: context.appColors.error, size: 20.sp),
                      badgeColor: context.appColors.error.withValues(alpha: .12),
                      title: 'Urgent System Alert',
                      timestamp: '3 days ago',
                      description: const TextSpan(
                        text: 'Clinic connectivity backup initiated. Data synchronization might be delayed.',
                      ),
                    ),
                    SizedBox(height: 12.h),
                    NotificationCard(
                      badge: Icon(Icons.campaign_outlined, color: context.appColors.textSecondary, size: 20.sp),
                      badgeColor: context.appColors.divider,
                      title: 'Software Update',
                      timestamp: '4 days ago',
                      description: const TextSpan(
                        text: 'Version 2.4 is now available. New patient dashboard features included.',
                      ),
                    ),
                    SizedBox(height: 28.h),

                    Center(
                      child: Column(
                        children: [
                          Icon(Icons.notifications_none, color: context.appColors.textSecondary.withValues(alpha: .4), size: 32.sp),
                          SizedBox(height: 8.h),
                          Text(
                            AppStrings.doctorNotificationsEmptyState.tr(),
                            style: AppTypography.regular14.copyWith(color: context.appColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTypography.medium12.copyWith(color: context.appColors.textSecondary, letterSpacing: .5),
    );
  }
}
