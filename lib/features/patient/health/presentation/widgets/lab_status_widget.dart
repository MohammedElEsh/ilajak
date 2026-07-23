import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/shared/widgets/status_widget.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class LabStatusWidget extends StatelessWidget {
  const LabStatusWidget({
    super.key,
    this.labName,
    required this.status,
    this.textColor,
    this.backgroundColor,
    this.titleTextStyle,
    this.showLabel = true,
    this.title,
  });
  final String? labName;
  final String status;
  final Color? textColor;
  final Color? backgroundColor;
  final TextStyle? titleTextStyle;
  final bool? showLabel;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title ?? 'LAB PANEL',
              style:
                  titleTextStyle ??
                  AppTypography.bold12.copyWith(color: AppColors.primary),
            ),
            StatusWidget(
              title: status,
              backgroundColor: backgroundColor ?? AppColors.lightRed,
              textColor: textColor ?? AppColors.error,
              textStyle: AppTypography.bold12.copyWith(
                color: textColor ?? AppColors.error,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        showLabel == true
            ? Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  labName ?? "Lab Name",
                  style: AppTypography.bold28.copyWith(
                    color: AppColors.textPrimaryLight,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
