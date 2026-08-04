import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

/// A single entry in the "Recent Visits" vertical timeline on Patient
/// Profile. Set [isLast] to hide the connector line below the last item.
class RecentVisitTimelineItem extends StatelessWidget {
  const RecentVisitTimelineItem({
    super.key,
    required this.icon,
    required this.title,
    required this.dateAndBy,
    this.note,
    this.pendingLabel,
    this.isLast = false,
  });

  final IconData icon;
  final String title;

  /// e.g. "Oct 12, 2023 • Dr. Sarah Jenkins"
  final String dateAndBy;

  /// Optional quoted note, e.g. patient/visit remarks.
  final String? note;

  /// Optional flag label, e.g. "RESULTS PENDING".
  final String? pendingLabel;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(color: context.appColors.primary, shape: BoxShape.circle),
                child: Icon(icon, color: context.appColors.surface, size: 16.sp),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: context.appColors.divider),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.semiBold16.copyWith(color: context.appColors.textPrimary)),
                  SizedBox(height: 2.h),
                  Text(dateAndBy, style: AppTypography.regular14.copyWith(color: context.appColors.textSecondary)),
                  if (note != null) ...[
                    SizedBox(height: 6.h),
                    Text(
                      '"$note"',
                      style: AppTypography.regular14.copyWith(
                        color: context.appColors.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  if (pendingLabel != null) ...[
                    SizedBox(height: 6.h),
                    Text(
                      pendingLabel!,
                      style: AppTypography.semiBold14.copyWith(color: context.appColors.error),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
