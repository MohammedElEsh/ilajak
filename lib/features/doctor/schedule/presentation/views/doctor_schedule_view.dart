import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/formatters/date_formatter.dart';
import 'package:ilajak/core/routing/route_names.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/chips/app_filter_chip.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/doctor/patients/presentation/views/doctor_patient_profile_view.dart';
import 'package:ilajak/features/doctor/schedule/data/models/appointment/appointment_model.dart';
import 'package:ilajak/features/doctor/schedule/logic/doctor_schedule_cubit/doctor_schedule_cubit.dart';
import 'package:ilajak/features/doctor/schedule/logic/doctor_schedule_cubit/doctor_schedule_state.dart';
import 'package:ilajak/features/doctor/schedule/presentation/widgets/doctor_schedule_appointment_card.dart';

// TODO(backend): the "All / Date / Client / Patient" filter chips are still
// visual-only — the backend has no documented query params for GET
// /appointments beyond the bare call, so there's nothing to wire them to
// yet. Ask backend if/when filtering should be added.
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
            backgroundColor: AppColors.primaryLight2,
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedHospital01,
              size: 20.sp,
              color: AppColors.primary,
              strokeWidth: 1.5,
            ),
          ),
          titleWidget: Text(
            AppStrings.doctorHomeAppBarTitle.tr(),
            style: AppTypography.semiBold18.copyWith(
              color: AppColors.primary,
            ),
          ),
          actionWidget: HugeIcon(
            icon: HugeIcons.strokeRoundedSearch01,
            size: 24.sp,
            color: AppColors.primary,
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
                            color: AppColors.textSecondary,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '${AppStrings.doctorScheduleTodayLabel.tr()}, '
                          '${DateFormatter.formatToMonthDay(DateTime.now())}',
                          style: AppTypography.extraBold24.copyWith(
                            color: AppColors.textPrimaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  ElevatedButton(
                    onPressed: () {
                      // TODO(backend): open the "New Appointment" creation flow.
                      // Also unconfirmed whether a doctor can call
                      // POST /appointments directly (named "(Patient)" in
                      // the Postman collection) — ask backend.
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          size: 18.sp,
                          color: AppColors.surfaceLight,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          AppStrings.doctorScheduleNewAppointment.tr(),
                          style: AppTypography.semiBold14.copyWith(
                            color: AppColors.surfaceLight,
                          ),
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
                  separatorBuilder: (_, _) => SizedBox(width: 10.w),
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
                child: BlocBuilder<DoctorScheduleCubit, DoctorScheduleState>(
                  builder: (context, state) {
                    if (state is DoctorScheduleLoading ||
                        state is DoctorScheduleInitial) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is DoctorScheduleError) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.r),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                state.message,
                                textAlign: TextAlign.center,
                                style: AppTypography.regular14.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              TextButton(
                                onPressed: () => context
                                    .read<DoctorScheduleCubit>()
                                    .loadAppointments(),
                                child: Text(AppStrings.sharedRetry.tr()),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final appointments = switch (state) {
                      DoctorScheduleLoaded(:final appointments) => appointments,
                      DoctorScheduleActionSuccess(:final appointments) =>
                        appointments,
                      _ => const <AppointmentModel>[],
                    };

                    if (appointments.isEmpty) {
                      return Center(
                        child: Text(
                          AppStrings.doctorScheduleNoAppointments.tr(),
                          style: AppTypography.regular14.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          for (final appt in appointments) ...[
                            _ScheduleRow(
                              time: appt.time ?? '',
                              child: DoctorScheduleAppointmentCard(
                                patientName: appt.patientName,
                                typeLabel: appt.type ?? '',
                                timeLabel: appt.time ?? '',
                                statusLabel: appt.status,
                                isPending: appt.isPending,
                                onConfirm: appt.isPending
                                    ? () => context
                                          .read<DoctorScheduleCubit>()
                                          .updateStatus(
                                            appointmentId: appt.id,
                                            status: 'confirmed',
                                          )
                                    : null,
                                onComplete: appt.isConfirmed
                                    ? () => context
                                          .read<DoctorScheduleCubit>()
                                          .updateStatus(
                                            appointmentId: appt.id,
                                            status: 'completed',
                                          )
                                    : null,
                                onCancel: (appt.isPending || appt.isConfirmed)
                                    ? () => context
                                          .read<DoctorScheduleCubit>()
                                          .updateStatus(
                                            appointmentId: appt.id,
                                            status: 'cancelled',
                                          )
                                    : null,
                                onViewDetails: appt.patientId != null
                                    ? () => context.push(
                                        RouteNames.doctorPatientProfileFullPath,
                                        extra: DoctorPatientProfileArgs(
                                          patientId: appt.patientId!,
                                          patientName: appt.patientName,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                            SizedBox(height: 16.h),
                          ],
                          SizedBox(height: 24.h + MediaQuery.of(context).padding.bottom),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One row of the timeline: a fixed-width time label on the left, and the
/// appointment card on the right.
class _ScheduleRow extends StatelessWidget {
  const _ScheduleRow({required this.time, required this.child});

  final String time;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 46.w,
            child: Text(
              time,
              style: AppTypography.semiBold14.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(child: child),
        ],
      ),
    );
  }
}
