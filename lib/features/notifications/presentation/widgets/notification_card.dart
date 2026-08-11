import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

/// Semantic meaning of a notification — drives its icon/badge color.
enum NotificationTone { primary, urgent, neutral }

/// A single flat notification row — no shadow, no border, no background
/// of its own. It's meant to live inside a `_DaySection` container
/// that supplies ONE shared surface + shadow for the whole day group,
/// with `Divider`s between rows.
class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.icon,
    required this.tone,
    required this.title,
    required this.description,
    required this.timestamp,
    this.isUnread = false,
    this.actions = const [],
    this.onTap,
  });

  final IconData icon;
  final NotificationTone tone;
  final String title;
  final InlineSpan description;

  /// e.g. "2m ago", "Yesterday, 9:15 AM"
  final String timestamp;
  final bool isUnread;

  /// Compact pill-style action buttons —
  /// sized to their label, not stretched full-width.
  final List<Widget> actions;

  final VoidCallback? onTap;

  Color _iconColor(BuildContext context) => switch (tone) {
        NotificationTone.primary => AppColors.primary,
        NotificationTone.urgent => AppColors.error,
        NotificationTone.neutral => AppColors.textSecondary,
      };

  Color _badgeColor(BuildContext context) => switch (tone) {
        NotificationTone.primary => AppColors.primaryLight2,
        NotificationTone.urgent => AppColors.error.withValues(alpha: .12),
        NotificationTone.neutral => AppColors.divider,
      };

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38.w,
            height: 38.h,
            decoration: BoxDecoration(color: _badgeColor(context), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(icon, size: 18.sp, color: _iconColor(context)),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: (isUnread ? AppTypography.semiBold14 : AppTypography.medium14)
                            .copyWith(color: AppColors.textPrimaryLight),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    if (isUnread)
                      Container(
                        width: 6.w,
                        height: 6.h,
                        margin: EdgeInsets.only(top: 5.h, right: 6.w),
                        decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      ),
                    Text(
                      timestamp,
                      style: AppTypography.regular12.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text.rich(
                  TextSpan(
                    style: AppTypography.regular13.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                    children: [description],
                  ),
                ),
                if (actions.isNotEmpty) ...[
                  SizedBox(height: 10.h),
                  Wrap(spacing: 8.w, runSpacing: 8.h, children: actions),
                ],
              ],
            ),
          ),
        ],
      ),
    );

    if (onTap == null) return content;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: content,
    );
  }
}
