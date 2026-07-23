import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.iconBackgroundColor = AppColors.secondary,
    this.iconColor = AppColors.primary,
    this.textColor = AppColors.textPrimaryLight,
    this.showDivider = false,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Color textColor;
  final bool showDivider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: iconBackgroundColor,
                  child: Icon(icon, color: iconColor, size: 24.sp),
                ),
                SizedBox(width: 16.w),
                Expanded(child: Text(title, style: AppTypography.regular14)),
                const Icon(Icons.chevron_right, color: AppColors.listTileArrowIcon),
              ],
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: EdgeInsets.only(left: 56.w, right: 56.w),
            child: const Divider(height: 1, color: AppColors.divider),
          ),
      ],
    );
  }
}
