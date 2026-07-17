import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../constants/app_strings.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _highlightedIndex;

  @override
  void initState() {
    super.initState();
    _highlightedIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(covariant BottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _highlightedIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 12.h),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: 0.08),
                blurRadius: 20.r,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            height: 64.h,
            selectedIndex: _highlightedIndex,
            onDestinationSelected: widget.onTap,
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return TextStyle(
                  fontSize: 9.sp,
                  color: theme.colorScheme.primary,
                );
              }
              return TextStyle(fontSize: 9.sp);
            }),
            destinations: [
              NavigationDestination(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedHome01,
                  size: 24,
                  color: theme.colorScheme.onSurface,
                ),
                selectedIcon: HugeIcon(
                  icon: HugeIcons.strokeRoundedHome01,
                  size: 24,
                  color: theme.colorScheme.primary,
                ),
                label: AppStrings.navHome.tr(),
              ),
              NavigationDestination(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedUser,
                  size: 24,
                  color: theme.colorScheme.onSurface,
                ),
                selectedIcon: HugeIcon(
                  icon: HugeIcons.strokeRoundedUser,
                  size: 24,
                  color: theme.colorScheme.primary,
                ),
                label: AppStrings.navPatients.tr(),
              ),
              NavigationDestination(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedBookOpen01,
                  size: 24,
                  color: theme.colorScheme.onSurface,
                ),
                selectedIcon: HugeIcon(
                  icon: HugeIcons.strokeRoundedBookOpen01,
                  size: 24,
                  color: theme.colorScheme.primary,
                ),
                label: AppStrings.navArticles.tr(),
              ),
              NavigationDestination(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedNotification01,
                  size: 24,
                  color: theme.colorScheme.onSurface,
                ),
                selectedIcon: HugeIcon(
                  icon: HugeIcons.strokeRoundedNotification01,
                  size: 24,
                  color: theme.colorScheme.primary,
                ),
                label: AppStrings.navNotifications.tr(),
              ),
              NavigationDestination(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedSettings01,
                  size: 24,
                  color: theme.colorScheme.onSurface,
                ),
                selectedIcon: HugeIcon(
                  icon: HugeIcons.strokeRoundedSettings01,
                  size: 24,
                  color: theme.colorScheme.primary,
                ),
                label: AppStrings.navProfile.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
