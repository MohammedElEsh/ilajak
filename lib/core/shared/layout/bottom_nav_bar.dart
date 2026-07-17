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
    final isCartActive = widget.currentIndex == 2;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            DecoratedBox(
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
                destinations: [
                  NavigationDestination(
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedHome01,
                      size: 24,
                      color: theme.colorScheme.onSurface,
                    ),
                    label: AppStrings.navHome.tr(),
                  ),
                  NavigationDestination(
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedFavourite,
                      size: 24,
                      color: theme.colorScheme.onSurface,
                    ),
                    label: AppStrings.navWishlist.tr(),
                  ),
                  const NavigationDestination(
                    icon: SizedBox.shrink(),
                    label: '',
                  ),
                  NavigationDestination(
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedSearch01,
                      size: 24,
                      color: theme.colorScheme.onSurface,
                    ),
                    label: AppStrings.navSearch.tr(),
                  ),
                  NavigationDestination(
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedSettings01,
                      size: 24,
                      color: theme.colorScheme.onSurface,
                    ),
                    label: AppStrings.navSettings.tr(),
                  ),
                ],
              ),
            ),

            /// Floating Cart Button
            Positioned(
              bottom: 18.h,
              child: GestureDetector(
                onTap: () => widget.onTap(2),
                child: Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    color: isCartActive
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.shadow.withValues(alpha: 0.12),
                        blurRadius: 15.r,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedShoppingBasket01,
                      size: 26,
                      color: isCartActive
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
