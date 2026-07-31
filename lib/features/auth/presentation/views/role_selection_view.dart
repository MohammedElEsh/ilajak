import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/services/session/session_manager.dart';

class RoleSelectionView extends StatelessWidget {
  const RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 48.w),
        child: Column(
          children: [
            SizedBox(height: 250.h),

            Text(
              AppStrings.roleSelectionTitle.tr(),
              style: theme.textTheme.displayLarge,
            ),
            SizedBox(height: 8.h),
            Text(
              AppStrings.roleSelectionSubtitle.tr(),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colors.onSurfaceVariant,
                wordSpacing: 2.sp,
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 48.h),
            _RoleCard(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedPatient,
                size: 28.sp,
                color: colors.primary,
              ),
              label: AppStrings.roleSelectionPatient.tr(),
              description: AppStrings.roleSelectionPatientDesc.tr(),
              onTap: () => _selectRole(context, UserRole.patient),
            ),
            SizedBox(height: 16.h),
            _RoleCard(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedStethoscope,
                size: 28.sp,
                color: colors.primary,
              ),
              label: AppStrings.roleSelectionDoctor.tr(),
              description: AppStrings.roleSelectionDoctorDesc.tr(),
              onTap: () => _selectRole(context, UserRole.doctor),
            ),
          ],
        ),
      ),
    );
  }

  void _selectRole(BuildContext context, UserRole role) {
    sl<SessionManager>().setRole(role);
    context.go(RouteNames.login);
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.label,
    required this.description,
    required this.onTap,
  });

  final Widget icon;
  final String label;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Material(
      color: colors.tertiaryContainer,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Row(
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(child: icon),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: theme.textTheme.titleLarge),
                    SizedBox(height: 4.h),
                    Text(
                      description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                size: 24.sp,
                color: colors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
