import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    this.controller,
    this.focusNode,
    this.hint,
    this.onChanged,
    this.onSubmitted,
    this.onVoiceTap,
    this.fillColor,
    this.iconColor,
    this.hintColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.elevation,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final String? hint;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onVoiceTap;

  final Color? fillColor;
  final Color? iconColor;
  final Color? hintColor;
  final Color? textColor;

  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final searchBar = theme.searchBarTheme;
    const states = <WidgetState>{};

    final bg = fillColor ?? AppColors.fieldInput;
    final hintStyle = searchBar.hintStyle?.resolve(states);
    final textStyle = searchBar.textStyle?.resolve(states);

    final radius =
        borderRadius ?? BorderRadius.circular(50.r);

    final fg = textColor ?? textStyle?.color ?? theme.colorScheme.onSurface;
    final hintClr = hintColor ?? hintStyle?.color ?? AppColors.fieldLabel;
    final icon = iconColor ?? hintClr;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: TextInputAction.search,
        cursorColor: theme.colorScheme.primary,
        style: textStyle?.copyWith(color: fg) ??
            theme.textTheme.bodyLarge?.copyWith(color: fg),
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: hint ?? AppStrings.homeSearchPlaceholder.tr(),
          hintStyle: (hintStyle ?? theme.textTheme.bodyLarge)
              ?.copyWith(color: hintClr),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 8.w),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedSearch01,
              color: icon,
              size: 20.r,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          suffixIcon: onVoiceTap != null
              ? GestureDetector(
                  onTap: onVoiceTap,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w, left: 8.w),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedMic01,
                      color: icon,
                      size: 20.r,
                    ),
                  ),
                )
              : null,
          suffixIconConstraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
        ),
      ),
    );
  }
}
