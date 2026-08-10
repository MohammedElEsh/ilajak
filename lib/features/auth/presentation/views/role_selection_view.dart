import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/services/session/session_manager.dart';
import '../../../../core/shared/buttons/app_button.dart';
import '../../../../core/theme/colors/app_colors.dart';

class RoleSelectionView extends StatefulWidget {
  const RoleSelectionView({super.key});

  @override
  State<RoleSelectionView> createState() => _RoleSelectionViewState();
}

class _RoleSelectionViewState extends State<RoleSelectionView>
    with SingleTickerProviderStateMixin {
  UserRole? _selectedRole;
  late final AnimationController _animController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _selectRole(UserRole role) {
    setState(() => _selectedRole = role);
  }

  void _confirmSelection() {
    if (_selectedRole == null) return;
    sl<SessionManager>().setRole(_selectedRole!);
    context.go(RouteNames.signup);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconButton(
                  onPressed: () => context.go(RouteNames.login),
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedArrowLeft01,
                    size: 24.sp,
                    color: colors.onSurface,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    children: [
                      SizedBox(height: 8.h),
                      _buildHeader(theme, colors),
                      SizedBox(height: 40.h),
                      _buildRoleCard(
                        context,
                        theme: theme,
                        colors: colors,
                        role: UserRole.patient,
                        iconData: HugeIcons.strokeRoundedPatient,
                        label: AppStrings.roleSelectionPatient.tr(),
                        description: AppStrings.roleSelectionPatientDesc.tr(),
                      ),
                      SizedBox(height: 16.h),
                      _buildRoleCard(
                        context,
                        theme: theme,
                        colors: colors,
                        role: UserRole.doctor,
                        iconData: HugeIcons.strokeRoundedStethoscope,
                        label: AppStrings.roleSelectionDoctor.tr(),
                        description: AppStrings.roleSelectionDoctorDesc.tr(),
                      ),
                      SizedBox(height: 40.h),
                      AppButton(
                        variant: AppButtonVariant.elevated,
                        label: AppStrings.sharedGetStarted.tr(),
                        onPressed: _selectedRole != null
                            ? _confirmSelection
                            : null,
                        enabled: _selectedRole != null,
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, ColorScheme colors) {
    return Column(
      children: [
        Container(
          width: 72.w,
          height: 72.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary, colors.primary.withValues(alpha: 0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22.r),
            boxShadow: [
              BoxShadow(
                color: colors.primary.withValues(alpha: 0.3),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedFirstAidKit,
              color: colors.onPrimary,
              size: 32.sp,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          AppStrings.roleSelectionTitle.tr(),
          style: theme.textTheme.headlineLarge?.copyWith(fontSize: 26.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          AppStrings.roleSelectionSubtitle.tr(),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colors.onSurfaceVariant,
            fontSize: 15.sp,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required ThemeData theme,
    required ColorScheme colors,
    required UserRole role,
    required dynamic iconData,
    required String label,
    required String description,
  }) {
    final isSelected = _selectedRole == role;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isSelected
            ? colors.primary.withValues(alpha: 0.08)
            : AppColors.fieldInput,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isSelected ? colors.primary : colors.outlineVariant,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: colors.primary.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          onTap: () => _selectRole(role),
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors.primary.withValues(alpha: 0.15)
                        : colors.primary.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Center(
                    child: HugeIcon(
                      icon: iconData,
                      size: 28.sp,
                      color: colors.primary,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: 17.sp,
                          color: isSelected ? colors.primary : colors.onSurface,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        description,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colors.onSurfaceVariant,
                          fontSize: 13.sp,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? colors.primary : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? colors.primary : AppColors.grey4,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Icon(Icons.check, size: 14.sp, color: colors.onPrimary)
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
