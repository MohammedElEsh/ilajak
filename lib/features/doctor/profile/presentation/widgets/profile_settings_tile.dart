import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

/// A single tappable row under "APP SETTINGS" on Doctor Profile
/// (e.g. Notifications, Password) — icon, label, trailing chevron.
class ProfileSettingsTile extends StatelessWidget {
  const ProfileSettingsTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: context.appColors.divider),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20.sp, color: context.appColors.textPrimary),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(label, style: AppTypography.semiBold16.copyWith(color: context.appColors.textPrimary)),
            ),
            Icon(Icons.chevron_right, color: context.appColors.listTileArrowIcon),
          ],
        ),
      ),
    );
  }
}
