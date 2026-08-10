import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

/// Semantic meaning of a notification — drives its icon/badge color.
///
/// REDESIGN NOTE: the old `NotificationCard` took a raw `Color badgeColor`
/// per call site, which is how the screen ended up with 6 different badge
/// colors carrying no consistent meaning. Collapsing to 3 tones with a
/// fixed meaning (act on this / urgent / just FYI) is the actual fix —
/// not a new palette, just discipline about when each existing color
/// gets used.
enum NotificationTone { primary, urgent, neutral }

/// A single flat notification row — no shadow, no border, no background
/// of its own. It's meant to live inside a `_DaySection` container
/// (`doctor_notifications_view.dart`) that supplies ONE shared surface +
/// shadow for the whole day group, with `Divider`s between rows.
///
/// [onTap], when provided, wraps the whole row in an `InkWell` — used by
/// the view to mark a notification read on tap, same as a real inbox.
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

  /// Compact pill-style action buttons (see `_ActionPill` in the view) —
  /// sized to their label, not stretched full-width.
  final List<Widget> actions;

  final VoidCallback? onTap;

  Color _iconColor(BuildContext context) => switch (tone) {
        NotificationTone.primary => context.appColors.primary,
        NotificationTone.urgent => context.appColors.error,
        NotificationTone.neutral => context.appColors.textSecondary,
      };

  Color _badgeColor(BuildContext context) => switch (tone) {
        NotificationTone.primary => context.appColors.primaryLight2,
        NotificationTone.urgent => context.appColors.error.withValues(alpha: .12),
        NotificationTone.neutral => context.appColors.divider,
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
                        // The ONE unread signal, together with the dot below —
                        // no more colored border + colored timestamp on top
                        // of this.
                        style: (isUnread ? AppTypography.semiBold14 : AppTypography.medium14)
                            .copyWith(color: context.appColors.textPrimary),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    if (isUnread)
                      Container(
                        width: 6.w,
                        height: 6.h,
                        margin: EdgeInsets.only(top: 5.h, right: 6.w),
                        decoration: BoxDecoration(color: context.appColors.primary, shape: BoxShape.circle),
                      ),
                    Text(
                      timestamp,
                      style: AppTypography.regular12.copyWith(color: context.appColors.textSecondary),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text.rich(
                  TextSpan(
                    style: AppTypography.regular13.copyWith(
                      color: context.appColors.textSecondary,
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
