import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_strings.dart';
import '../../services/logger/logger_service.dart';
import '../../theme/colors/app_colors.dart';
import '../buttons/app_button.dart';

class OfflineWidget extends StatefulWidget {
  final VoidCallback onRetry;

  const OfflineWidget({super.key, required this.onRetry});

  @override
  State<OfflineWidget> createState() => _OfflineWidgetState();
}

class _OfflineWidgetState extends State<OfflineWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    LoggerService.i('OfflineWidget displayed', tag: 'Connectivity');
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScaleTransition(
                scale: _pulseAnimation,
                child: Container(
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.wifi_off_rounded,
                      size: 48.r,
                      color: AppColors.error,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                AppStrings.sharedNoInternet.tr(),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                AppStrings.sharedNoInternetSubtitle.tr(),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13.sp,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 28.h),
              AppButton(
                label: AppStrings.sharedRetry.tr(),
                onPressed: widget.onRetry,
                variant: AppButtonVariant.elevated,
                prefixIcon: Icon(Icons.refresh_rounded, size: 20.r),
                expanded: false,
                width: 180.w,
                height: 48.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
