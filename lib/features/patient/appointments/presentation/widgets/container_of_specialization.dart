import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class ContainerOfSpecialization extends StatelessWidget {
  const ContainerOfSpecialization({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: AppColors.fieldBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: AppTypography.regular16.copyWith(
                color: isSelected
                    ? AppColors.backgroundLight
                    : AppColors.darkMint,
              ),
            ),
            SizedBox(width: 6.w),
            HugeIcon(
              icon: HugeIcons.strokeRoundedArrowDown01,
              size: 20,
              color: isSelected
                  ? AppColors.backgroundLight
                  : AppColors.darkMint,
              strokeWidth: 1.5,
            ),
          ],
        ),
      ),
    );
  }
}
