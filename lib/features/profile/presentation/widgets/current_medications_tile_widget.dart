import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class CurrentMedicationsTile extends StatelessWidget {
  const CurrentMedicationsTile({
    super.key,
    required this.name,
    required this.dose,
    this.onTap,
  });

  final String name;
  final String dose;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      tileColor: AppColors.primaryLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),

      leading: Container(
        width: 48.w,
        height: 48.h,
        decoration: const BoxDecoration(
          color: AppColors.surfaceLight,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.medication_outlined,
          color: AppColors.primary,
          size: 24.sp,
        ),
      ),

      title: Text(
        name,
        style: AppTypography.medium16.copyWith(
          color: AppColors.textPrimaryLight,
        ),
      ),

      subtitle: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: Text(
          dose,
          style: AppTypography.medium12.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),

      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.listTileArrowIcon,
        size: 22.sp,
      ),
    );
  }
}
