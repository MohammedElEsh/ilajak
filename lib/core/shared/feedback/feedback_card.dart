import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors/app_colors.dart';
import 'feedback_message.dart';

class FeedbackCard extends StatelessWidget {
  final FeedbackMessage message;
  final VoidCallback? onDismiss;

  const FeedbackCard({
    super.key,
    required this.message,
    this.onDismiss,
  });

  Color _backgroundColor(BuildContext context) {
    switch (message.type) {
      case FeedbackType.success:
        return AppColors.success.withValues(alpha: 0.12);
      case FeedbackType.error:
        return AppColors.error.withValues(alpha: 0.12);
      case FeedbackType.info:
        return AppColors.info.withValues(alpha: 0.12);
      case FeedbackType.warning:
        return AppColors.warning.withValues(alpha: 0.12);
    }
  }

  Color _borderColor(BuildContext context) {
    switch (message.type) {
      case FeedbackType.success:
        return AppColors.success;
      case FeedbackType.error:
        return AppColors.error;
      case FeedbackType.info:
        return AppColors.info;
      case FeedbackType.warning:
        return AppColors.warning;
    }
  }

  Color _iconColor(BuildContext context) {
    switch (message.type) {
      case FeedbackType.success:
        return AppColors.success;
      case FeedbackType.error:
        return AppColors.error;
      case FeedbackType.info:
        return AppColors.info;
      case FeedbackType.warning:
        return AppColors.warning;
    }
  }

  IconData get _icon {
    switch (message.type) {
      case FeedbackType.success:
        return Icons.check_circle_outline;
      case FeedbackType.error:
        return Icons.error_outline;
      case FeedbackType.info:
        return Icons.info_outline;
      case FeedbackType.warning:
        return Icons.warning_amber_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: _backgroundColor(context),
        borderRadius: BorderRadius.circular(10.r),
        border:
            Border.all(color: _borderColor(context).withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(_icon, color: _iconColor(context), size: 20.r),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.title != null) ...[
                  Text(
                    message.title!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: _iconColor(context),
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
                Text(
                  message.description,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          if (onDismiss != null)
            GestureDetector(
              onTap: onDismiss,
              child: Icon(
                Icons.close,
                size: 16.r,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }
}
