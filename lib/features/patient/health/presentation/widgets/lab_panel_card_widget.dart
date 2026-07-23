import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/features/patient/health/presentation/widgets/date_with_place_widget.dart';
import 'package:ilajak/features/patient/health/presentation/widgets/disease_and_optimal_result_widget.dart';
import 'package:ilajak/features/patient/health/presentation/widgets/lab_status_widget.dart';
import 'package:ilajak/features/patient/health/presentation/widgets/range_indicator_Widget.dart';

class LabPanelCardWidget extends StatelessWidget {
  const LabPanelCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadiusDirectional.circular(20.r),
        border: Border.all(color: AppColors.surfaceLight, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: AppColors.surfaceDark.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // Container body
      child: Column(
        children: [
          // Lab & Status Header
          const LabStatusWidget(labName: 'Lipid Profile', status: 'High Risk'),
          SizedBox(height: 32.h),

          // Disease result & Optimal result
          const DiseaseAndOptimalResultWidget(
            diseaseName: 'TOTAL CHOLESTEROL',
            diseaseResult: '228 ',
            optimalRange: '< 200 mg/dL',
          ),
          SizedBox(height: 24.h),

          // Multi-color Normal Range Bar
          const RangeIndicatorBar(value: 228, min: 125, max: 300),
          SizedBox(height: 24.h),

          // Date With Place
          const DateWithPlaceWidget(),
        ],
      ),
    );
  }
}
