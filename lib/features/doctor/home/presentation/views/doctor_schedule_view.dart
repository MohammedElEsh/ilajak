import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/formatters/date_formatter.dart';
import 'package:ilajak/core/routing/route_names.dart';
import 'package:ilajak/core/shared/chips/app_filter_chip.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/layout/bottom_nav_clearance.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/doctor/home/presentation/widgets/doctor_schedule_appointment_card.dart';

// TODO(backend): placeholder day + placeholder appointments — swap for the
// real doctor-schedule cubit once the API/integration work starts.
class DoctorScheduleView extends StatefulWidget {
  const DoctorScheduleView({super.key});

  @override
  State<DoctorScheduleView> createState() => _DoctorScheduleViewState();
}

class _DoctorScheduleViewState extends State<DoctorScheduleView> {
  static const _filterKeys = [
    AppStrings.doctorScheduleFilterAll,
    AppStrings.doctorScheduleFilterDate,
    AppStrings.doctorScheduleFilterClient,
    AppStrings.doctorScheduleFilterPatient,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.doctorScheduleEyebrow.tr(),
                          style: AppTypography.medium12.copyWith(
                            color: context.appColors.textSecondary,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '${AppStrings.doctorScheduleTodayLabel.tr()}, '
                          '${DateFormatter.formatToMonthDay(DateTime.now())}',
                          style: AppTypography.extraBold24.copyWith(color: context.appColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  ElevatedButton(
                    onPressed: () {
                      // TODO(backend): open the "New Appointment" creation flow.
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.appColors.primary,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 18.sp, color: context.appColors.surface),
                        SizedBox(width: 6.w),
                        Text(
                          AppStrings.doctorScheduleNewAppointment.tr(),
                          style: AppTypography.semiBold14.copyWith(color: context.appColors.surface),
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
                    final selected = index == _selectedFilterIndex;
                    return AppFilterChip(
                      label: _filterKeys[index].tr(),
                      selected: selected,
                      onTap: () => setState(() => _selectedFilterIndex = index),
                    );
                  },
                ),
              ),
              SizedBox(height: 8.h),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _ScheduleRow(time: '9:00', child: null),
                      _ScheduleRow(
                        time: '9:30',
                        child: DoctorScheduleAppointmentCard(
                          patientName: 'James Wilson',
                          typeLabel: 'Consultation',
                          timeLabel: '9:30 AM',
                          statusLabel: AppStrings.doctorScheduleStatusConfirmed.tr(),
                          onConfirm: () {},
                          onComplete: () {},
                          onCancel: () {},
                          onViewDetails: () => context.push(RouteNames.doctorPatientProfileFullPath),
                        ),
                      ),
                      _ScheduleRow(time: '10:00', child: null),
                      _ScheduleRow(
                        time: '11:15',
                        child: DoctorScheduleAppointmentCard(
                          patientName: 'Sarah Chen',
                          typeLabel: 'Follow-up',
                          timeLabel: '11:15 AM',
                          statusLabel: AppStrings.doctorScheduleStatusPending.tr(),
                          isPending: true,
                          onConfirm: () {},
                          onReschedule: () {},
                        ),
                      ),
                      _ScheduleRow(
                        time: '12:00',
                        child: _LunchBreakDivider(
                          label: AppStrings.doctorScheduleLunchBreak.tr(),
                        ),
                      ),
                      _ScheduleRow(
                        time: '1:00',
                        child: _EmptySlotPlaceholder(
                          label: AppStrings.doctorScheduleNoAppointments.tr(),
                        ),
                      ),
                      _ScheduleRow(
                        time: '2:30',
                        child: DoctorScheduleAppointmentCard(
                          patientName: 'Michael Rodriguez',
                          typeLabel: 'Check-up',
                          timeLabel: '2:30 PM',
                          statusLabel: AppStrings.doctorScheduleStatusConfirmed.tr(),
                          onConfirm: () {},
                          onComplete: () {},
                        ),
                      ),
                      _ScheduleRow(time: '5:00', child: null),
                      SizedBox(height: 24.h + context.bottomNavClearance),
                    ],
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

/// One row of the timeline: a fixed-width time label on the left, and
/// either an appointment card, a break/empty-state widget, or (when
/// [child] is null) a plain divider line for the untouched hours.
class _ScheduleRow extends StatelessWidget {
  const _ScheduleRow({required this.time, required this.child});

  final String time;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 46.w,
            child: Text(
              time,
              style: AppTypography.semiBold14.copyWith(
                color: child == null ? context.appColors.textSecondary : context.appColors.primary,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: child ?? Divider(height: 1, color: context.appColors.divider),
          ),
        ],
      ),
    );
  }
}

class _LunchBreakDivider extends StatelessWidget {
  const _LunchBreakDivider({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: context.appColors.divider)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            label,
            style: AppTypography.regular13.copyWith(color: context.appColors.textSecondary),
          ),
        ),
        Expanded(child: Divider(color: context.appColors.divider)),
      ],
    );
  }
}

class _EmptySlotPlaceholder extends StatelessWidget {
  const _EmptySlotPlaceholder({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedRectPainter(color: context.appColors.divider, radius: 14.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 18.h),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTypography.regular14.copyWith(color: context.appColors.textSecondary),
        ),
      ),
    );
  }
}

/// Manual dashed rounded-rect border — avoids pulling in an extra pub
/// dependency just for the empty-slot placeholder.
class _DashedRectPainter extends CustomPainter {
  _DashedRectPainter({required this.color, required this.radius, this.gap = 4});

  final Color color;
  final double radius;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0;
      const dashLength = 5.0;
      while (distance < metric.length) {
        final next = distance + dashLength;
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRectPainter oldDelegate) => false;
}
