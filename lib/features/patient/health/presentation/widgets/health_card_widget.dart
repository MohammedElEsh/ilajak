import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/widgets/status_widget.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/health/presentation/widgets/app_icon_outlined_button.dart';
import 'package:ilajak/features/patient/health/presentation/widgets/app_primary_action_button.dart';
import 'package:ilajak/features/patient/health/presentation/widgets/lab_card_Info_widget.dart';

class HealthCardWidget extends StatelessWidget {
  const HealthCardWidget({
    super.key,
    this.title,
    this.subtitle,
    this.status,
    this.statusColor,
    this.statusBackgroundColor,
    this.labValue,
    this.value,
    this.valueColor,
    this.unit,
    this.normalRange,
    this.onViewDetailsPressed,
    this.onDownloadPressed,
    this.icon,
  });
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final String? status;
  final Color? statusColor;
  final Color? statusBackgroundColor;
  final String? labValue;
  final String? value;
  final Color? valueColor;
  final String? unit;
  final String? normalRange;
  final void Function()? onViewDetailsPressed;
  final void Function()? onDownloadPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          // Headre Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Row of title and statu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 24.sp, color: AppColors.primary),
                      SizedBox(width: 8.w),
                      Text(
                        title ?? "Lipid Profile",
                        style: AppTypography.semiBold18.copyWith(
                          color: AppColors.textPrimaryLight,
                        ),
                      ),
                    ],
                  ),
                  StatusWidget(
                    title: status ?? "High",
                    backgroundColor:
                        statusBackgroundColor ??
                        AppColors.redTileIconBackgroundColor,
                    textColor: statusColor ?? AppColors.error,
                    textStyle: AppTypography.bold12.copyWith(
                      color: statusColor ?? AppColors.error,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              // Text
              Text(
                subtitle ?? "Oct 24, 2023 • General Checkup",
                style: AppTypography.regular16.copyWith(
                  color: AppColors.textPrimaryLight,
                  height: 1.5,
                  wordSpacing: 1,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: LabCardInfoWidget(
                      label: labValue ?? 'TOTAL CHOLESTEROL',
                      value: value ?? '245',
                      valueColor: valueColor ?? AppColors.error,
                      unit: unit ?? 'mg/dL',
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: LabCardInfoWidget(
                      label: normalRange ?? 'Normal Range',
                      value: value ?? '125 - 200',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: AppPrimaryActionButton(
                      label: AppStrings.viewDetails.tr(),
                      onPressed: onViewDetailsPressed ?? () {},
                      icon: Icons.remove_red_eye_outlined,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  AppIconOutlineButton(
                    onPressed: onDownloadPressed ?? () {},
                    icon: Icons.download_outlined,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
