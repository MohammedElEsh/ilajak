import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/routing/route_names.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/home/presentation/widgets/category_widget.dart';
import 'package:ilajak/features/patient/home/presentation/widgets/conditions_report_widget.dart';
import 'package:ilajak/features/patient/home/presentation/widgets/health_insight_card.dart';
import 'package:ilajak/features/patient/home/presentation/widgets/row_text_button_widget.dart';
import 'package:ilajak/features/patient/home/presentation/widgets/status_widget.dart';
import 'package:ilajak/features/patient/home/presentation/widgets/time_line_card_widget.dart';
import 'package:ilajak/features/patient/home/presentation/widgets/time_line_indicator_widget.dart';
import 'package:ilajak/features/patient/home/presentation/widgets/upcomingappointment_widget.dart';

class PatientHomeView extends StatelessWidget {
  const PatientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Scaffold(
        appBar: AppTopBar(
          leadingWidget: CircleAvatar(
            radius: 20.r,
            backgroundImage: const AssetImage(AppAssets.profileImage),
          ),
          actionWidget: HugeIcon(
            icon: HugeIcons.strokeRoundedSearch01,
            size: 24.sp,
            color: AppColors.primary,
            strokeWidth: 1.5,
          ),
          titleWidget: Text(
            AppStrings.homeAppBarTitle.tr(),
            style: AppTypography.bold28.copyWith(color: AppColors.primary),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Text(
                      AppStrings.homeTitle.tr(),
                      style: AppTypography.bold28.copyWith(
                        color: AppColors.backgroundDark,
                      ),
                    ),
                    Text(
                      "Ahmed",
                      style: AppTypography.bold28.copyWith(
                        color: AppColors.backgroundDark,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                Text(
                  AppStrings.homeSubtitle.tr(),
                  style: AppTypography.regular14.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    CategoryWidget(
                      icon: const HugeIcon(
                        icon: HugeIcons.strokeRoundedPrescriptions,
                        size: 30,
                        color: AppColors.primary,
                        strokeWidth: 1.5,
                      ),
                      title: AppStrings.homePerciptions.tr(),
                      onTap: () =>
                          context.push(RouteNames.patientPrescriptions),
                    ),
                    const Spacer(),

                    CategoryWidget(
                      icon: const HugeIcon(
                        icon: HugeIcons.strokeRoundedAiChemistry02,
                        size: 30,
                        color: AppColors.primary,
                        strokeWidth: 1.5,
                      ),
                      title: AppStrings.homeLabs.tr(),
                      onTap: () {},
                    ),
                    const Spacer(),

                    CategoryWidget(
                      icon: const HugeIcon(
                        icon: HugeIcons.strokeRoundedXRay,
                        size: 30,
                        color: AppColors.primary,
                        strokeWidth: 1.5,
                      ),
                      title: AppStrings.homeImaging.tr(),
                      onTap: () {},
                    ),
                    const Spacer(),

                    CategoryWidget(
                      icon: const HugeIcon(
                        icon: HugeIcons.strokeRoundedCalendar02,
                        size: 30,
                        color: AppColors.primary,
                        strokeWidth: 1.5,
                      ),
                      title: AppStrings.homeAppointments.tr(),
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                const UpcomingAppointmentWidget(
                  title1: 'Dr. Sarah Johnson',
                  title2: 'Cardiology . ',
                  time: 'Today, 2:30 PM',
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    const StatusWidget(
                      image: HugeIcon(
                        icon: HugeIcons.strokeRoundedBandage,
                        size: 24.0,
                        color: AppColors.backgroundLight,
                        strokeWidth: 1.5,
                      ),
                      title: "PRESCRIPTIONS",
                      analysisName: "Lisinopril",
                      analysisResult: "10mg • Daily",
                      color2: AppColors.primary,
                    ),
                    SizedBox(width: 16.w),

                    const StatusWidget(
                      image: HugeIcon(
                        icon: HugeIcons.strokeRoundedMicroscope,
                        size: 24.0,
                        color: AppColors.backgroundLight,
                        strokeWidth: 1.5,
                      ),
                      title: "LATEST LAB",
                      analysisName: "Glucose",
                      analysisResult: "Normal",
                      color2: AppColors.success,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    StatusWidget(
                      title: "BLOOD TYPE",
                      analysisResult: "O+ Universal",
                      color2: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(width: 16.w),

                    StatusWidget(
                      title: "ALLERGIES",
                      analysisName: "Penicillin",
                      analysisResult: "Severe Reaction",
                      color1: Theme.of(context).colorScheme.error,
                      color2: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                const ConditionsReportWidget(
                  title: "CONDITIONS",
                  subTitle: "None Reported",
                ),
                SizedBox(height: 24.h),
                RowTextButtonWidget(
                  title: "Health Timeline",
                  buttonText: "View All",
                  onTap: () {},
                ),
                SizedBox(height: 16.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TimeLineIndicatorWidget(
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedAmpoule,
                        size: 24.0,
                        color: AppColors.backgroundLight,
                        strokeWidth: 1.5,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    const Expanded(
                      child: TimeLineCardWidget(
                        title: 'Flu Vaccination',
                        subTitle:
                            'Annual booster completed at Central Pharmacy',
                        time: 'Oct 12',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TimeLineIndicatorWidget(
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedDocumentAttachment,
                        size: 24.0,
                        color: AppColors.backgroundLight,
                        strokeWidth: 1.5,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    const Expanded(
                      child: TimeLineCardWidget(
                        title: 'Blood Test Results',
                        subTitle:
                            'All parameters within normal range.View report',
                        time: 'Sep 28',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                const HealthInsightCard(),
                SizedBox(height: 96.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
