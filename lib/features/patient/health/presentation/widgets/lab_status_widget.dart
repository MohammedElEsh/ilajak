import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/shared/widgets/status_widget.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class LabStatusWidget extends StatelessWidget {
  const LabStatusWidget({
    super.key,
    required this.labName,
    required this.status,
  });
  final String labName;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'LAB PANEL',
              style: AppTypography.bold12.copyWith(color: AppColors.primary),
            ),
            StatusWidget(
              title: status,
              backgroundColor: AppColors.lightRed,
              textColor: AppColors.error,
              textStyle: AppTypography.bold12.copyWith(color: AppColors.error),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            labName,
            style: AppTypography.bold28.copyWith(
              color: AppColors.textPrimaryLight,
            ),
          ),
        ),
      ],
    );
  }
}
