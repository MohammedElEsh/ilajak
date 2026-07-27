import 'package:flutter/material.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/health/presentation/widgets/lab_status_widget.dart';

class LabResultItemProgress extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String statusText;
  final Color barColor;
  final double progressValue;
  final String optimalRange;
  final Color? statusTextColor;
  final Color? statusBgColor;

  const LabResultItemProgress({
    super.key,
    required this.title,
    required this.value,
    this.unit = 'mg/dL',
    required this.statusText,
    required this.barColor,
    required this.progressValue,
    required this.optimalRange,
    this.statusBgColor,
    this.statusTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.surfaceDark.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          LabStatusWidget(
            title: title,
            titleTextStyle: AppTypography.medium12.copyWith(
              color: AppColors.textSecondary,
            ),
            status: statusText,
            showLabel: false,
            backgroundColor: statusBgColor,
            textColor: statusTextColor,
          ),
          const SizedBox(height: 8),

          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: AppTypography.semiBold22.copyWith(
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                TextSpan(
                  text: unit,
                  style: AppTypography.regular14.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progressValue.clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: AppColors.lightGray,
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
            ),
          ),
          const SizedBox(height: 8),

          Text(
            optimalRange,
            style: AppTypography.regular14.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
