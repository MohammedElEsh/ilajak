import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';


class LabPendingResultCard extends StatelessWidget {
  const LabPendingResultCard({super.key});

  @override
  Widget build(BuildContext context) {
    const Color cardBackgroundColor = AppColors.primaryLight2;
    final Color cardBorderColor = AppColors.primary.withValues(alpha: .2);
    const Color iconColor = AppColors.primary;
    const Color textColor = AppColors.primary;

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
        decoration: BoxDecoration(
          color: cardBackgroundColor,
          border: Border.all(color: cardBorderColor, width: 1.0),
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 1.0.r, right: 12.0.w),
                child: Icon(Icons.info_outline, size: 22.sp, color: iconColor),
              ),
              Flexible(
                child: Text(
                  AppStrings.radiologyHintMsg.tr(),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.regular16.copyWith(
                    color: textColor,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
