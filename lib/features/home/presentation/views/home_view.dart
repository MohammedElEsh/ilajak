import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/home/presentation/widgets/category_widget.dart';
import 'package:ilajak/features/home/presentation/widgets/conditions_report_widget.dart';
import 'package:ilajak/features/home/presentation/widgets/health_insight_card.dart';
import 'package:ilajak/features/home/presentation/widgets/row_text_button_widget.dart';
import 'package:ilajak/features/home/presentation/widgets/status_widget.dart';
import 'package:ilajak/features/home/presentation/widgets/time_line_card_widget.dart';
import 'package:ilajak/features/home/presentation/widgets/time_line_indicator_widget.dart';
import 'package:ilajak/features/home/presentation/widgets/upcomingappointment_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Scaffold(
        appBar: AppTopBar(
          leadingWidget: Image.asset(
            AppAssets.imageProfile,
            width: 40.w,
            height: 40.h,
          ),
          actionWidget: Image.asset(
            AppAssets.searchIcon,
            width: 18.w,
            height: 18.h,
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryWidget(
                        icon: AppAssets.category1Icon,
                        title: AppStrings.homePerciptions.tr(),
                        onTap: () {},
                      ),
                      SizedBox(width: 32.w),

                      CategoryWidget(
                        icon: AppAssets.category2Icon,
                        title: AppStrings.homeLabs.tr(),
                        onTap: () {},
                      ),
                      SizedBox(width: 32.w),

                      CategoryWidget(
                        icon: AppAssets.category3Icon,
                        title: AppStrings.homeImaging.tr(),
                        onTap: () {},
                      ),
                      SizedBox(width: 32.w),

                      CategoryWidget(
                        icon: AppAssets.category4Icon,
                        title: AppStrings.homeAppointments.tr(),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),

                UpcomingAppointmentWidget(
                  title1: 'Dr. Sarah Johnson',
                  title2: 'Cardiology . ',
                  time: 'Today, 2:30 PM',
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    StatusWidget(
                      image: AppAssets.prescriptionIcon,
                      title: "PRESCRIPTIONS",
                      analysisName: "Lisinopril",
                      analysisResult: "10mg • Daily",
                      color2: AppColors.primary,
                    ),
                    SizedBox(width: 16.w),

                    StatusWidget(
                      image: AppAssets.microscopeIcon,
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
                      color2: AppColors.textSecondary,
                    ),
                    SizedBox(width: 16.w),

                    StatusWidget(
                      title: "ALLERGIES",
                      analysisName: "Penicillin",
                      analysisResult: "Severe Reaction",
                      color1: Theme.of(context).colorScheme.error,
                      color2: AppColors.textSecondary,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ConditionsReportWidget(
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
                    TimeLineIndicatorWidget(icon: AppAssets.vaccineIcon),
                    SizedBox(width: 16.w),
                    Expanded(
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
                    TimeLineIndicatorWidget(icon: AppAssets.reportIcon),
                    SizedBox(width: 16.w),
                    Expanded(
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
                HealthInsightCard(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
