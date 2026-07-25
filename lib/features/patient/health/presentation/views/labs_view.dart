import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/health/presentation/widgets/historical_trend_chart_widget.dart';
import 'package:ilajak/features/patient/health/presentation/widgets/lab_panel_card_widget.dart';
import 'package:ilajak/features/patient/health/presentation/widgets/lab_result_item_progress.dart';

class LabResultsView extends StatelessWidget {
  const LabResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        leadingWidget: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.sp),
        ),
        titleWidget: Text(
          'Lab Results',
          style: AppTypography.semiBold22.copyWith(
            color: AppColors.textPrimaryLight,
          ),
        ),
      ),
      // I'll get all the data from the clicable labs in the health page
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                const LabPanelCardWidget(),
                SizedBox(height: 24.h),
                const HistoricalTrendChart(),
                SizedBox(height: 24.h),
                const LabResultItemProgress(
                  title: 'LDL (BAD)',
                  value: '160',
                  unit: 'mg/dL',
                  statusText: 'HIGH',
                  barColor: AppColors.error,
                  progressValue: 0.8,
                  optimalRange: 'Optimal: < 100 mg/dL',
                  statusBgColor: AppColors.lightRed,
                  statusTextColor: AppColors.error,
                ),
                SizedBox(height: 16.h),
                const LabResultItemProgress(
                  title: 'HDL (GOOD)',
                  value: '45',
                  unit: 'mg/dL',
                  statusText: 'NORMAL',
                  barColor: AppColors.primary,
                  progressValue: 0.4,
                  optimalRange: 'Optimal: > 40 mg/dL',
                  statusBgColor: AppColors.primaryLight2,
                  statusTextColor: AppColors.primary,
                ),
                SizedBox(height: 16.h),
                const LabResultItemProgress(
                  title: 'TRIGLYCERIDES',
                  value: '155',
                  unit: 'mg/dL',
                  // Between NORMAL & HIGH text
                  statusText: 'AVG NORM',
                  barColor: AppColors.primary,
                  progressValue: 0.6,
                  optimalRange: 'Optimal: < 150 mg/dL',
                  statusBgColor: AppColors.primaryLight2,
                  statusTextColor: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
