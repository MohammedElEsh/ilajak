import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class DiseaseAndOptimalResultWidget extends StatelessWidget {
  const DiseaseAndOptimalResultWidget({
    super.key,
     required this.diseaseName, 
     required this.diseaseResult, 
     required this.optimalRange,
  });
  final String diseaseName;
  final String diseaseResult;
  final String optimalRange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              diseaseName,
              style: AppTypography.medium12.copyWith(
                color: AppColors.textPrimaryLight,
              ),
            ),
            SizedBox(height: 2.h),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$diseaseResult ',
                    style: AppTypography.semiBold22.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                  TextSpan(
                    text: ' mg/dL',
                    style: AppTypography.regular14.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    
        // Right Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Optimal',
              style: AppTypography.medium12.copyWith(
                color: AppColors.textPrimaryLight,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              optimalRange,
              style: AppTypography.semiBold16.copyWith(
                color: AppColors.textPrimaryLight,
              ),
            ),
          ],
        ),
      ],
    );
  }
}