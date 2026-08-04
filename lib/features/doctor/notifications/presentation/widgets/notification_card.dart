import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

/// A single notification row on Doctor Notifications.
///
/// [description] is an [InlineSpan] rather than a plain [String] so the
/// caller can bold a patient's name and/or color an "urgent" phrase inline
/// — that mix varies per notification and doesn't fit a single string.
///
/// [isUnread] adds the left accent bar + blue timestamp + dot. Pass
/// [backgroundColor] to override the card fill for a special state (e.g.
/// the muted gray "cancelled" notification in the mock).
class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.badge,
    required this.badgeColor,
    required this.title,
    required this.description,
    required this.timestamp,
    this.isUnread = false,
    this.backgroundColor,
    this.actions = const [],
  });

  final Widget badge;
  final Color badgeColor;
  final String title;
  final InlineSpan description;

  /// e.g. "2m ago", "Yesterday, 9:15 AM"
  final String timestamp;
  final bool isUnread;
  final Color? backgroundColor;

  /// Pre-built action buttons (e.g. ElevatedButton "View Details" +
  /// OutlinedButton "Accept"). Laid out in a Row, evenly spaced.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.appColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: isUnread ? Border(left: BorderSide(color: context.appColors.primary, width: 4)) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(color: badgeColor, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: badge,
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
                        style: AppTypography.semiBold16.copyWith(color: context.appColors.textPrimary),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      timestamp,
                      style: AppTypography.medium12.copyWith(
                        color: isUnread ? context.appColors.primary : context.appColors.textSecondary,
                      ),
                    ),
                    if (isUnread) ...[
                      SizedBox(width: 6.w),
                      Container(
                        width: 7.w,
                        height: 7.h,
                        decoration: BoxDecoration(color: context.appColors.primary, shape: BoxShape.circle),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 6.h),
                Text.rich(
                  TextSpan(
                    style: AppTypography.regular14.copyWith(color: context.appColors.textSecondary),
                    children: [description],
                  ),
                ),
                if (actions.isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      for (var i = 0; i < actions.length; i++) ...[
                        if (i > 0) SizedBox(width: 10.w),
                        Expanded(child: actions[i]),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
