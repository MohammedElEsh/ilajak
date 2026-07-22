import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class DiseaseWidget extends StatelessWidget {
  const DiseaseWidget({
    super.key,
    required this.diseaseName,
    required this.diagnosisDate,
  });
  final String diseaseName;
  final String diagnosisDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLight2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                diseaseName,
                style: AppTypography.semiBold16.copyWith(
                  color: AppColors.textPrimaryLight,
                ),
              ),
              Icon(
                Icons.info_outlined,
                color: AppColors.primary,
                size: 24.sp,
              ),
            ],
          ),
          Text(
            diagnosisDate,
            style: AppTypography.regular16.copyWith(
              color: AppColors.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
