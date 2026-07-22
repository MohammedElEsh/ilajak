import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onProfileTap;
  final Widget? leadingWidget;
  final Widget? actionWidget;
  final Widget? titleWidget;
  final bool? centerTitle;
  final String? title;

  const AppTopBar({
    super.key,
    this.onMenuTap,
    this.onProfileTap,
    this.leadingWidget,
    this.actionWidget,
    this.titleWidget,
    this.centerTitle,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final useTitle = title != null;

    return AppBar(
      title: useTitle
          ? Text(
              title!,
              style: AppTypography.bold28.copyWith(color: AppColors.primary),
            )
          : null,
      centerTitle: centerTitle ?? false,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leadingWidth: useTitle ? null : 210.w,
      leading: useTitle
          ? leadingWidget
          : Row(
              children: [
                leadingWidget ?? const SizedBox.shrink(),
                SizedBox(width: 12.w),
                Expanded(child: titleWidget ?? const SizedBox.shrink()),
              ],
            ),
      actions: [actionWidget ?? const SizedBox.shrink()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}