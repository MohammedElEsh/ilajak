import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_strings.dart';
import '../../shared/buttons/app_button.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const AppErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: theme.colorScheme.error, size: 64),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 24.h),
            AppButton(
              variant: AppButtonVariant.elevated,
              label: AppStrings.sharedRetry.tr(),
              onPressed: onRetry,
              expanded: false,
            ),
          ],
        ),
      ),
    );
  }
}
