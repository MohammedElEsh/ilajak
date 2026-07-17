import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../constants/app_strings.dart';

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

    final bg = fillColor ?? searchBar.backgroundColor?.resolve(states);
    final hintStyle = searchBar.hintStyle?.resolve(states);
    final textStyle = searchBar.textStyle?.resolve(states);
    final elev = elevation ?? searchBar.elevation?.resolve(states) ?? 0;

    final OutlinedBorder? shape = searchBar.shape?.resolve(states);
    BorderRadius? radius = borderRadius;
    if (radius == null && shape is RoundedRectangleBorder) {
      radius = shape.borderRadius as BorderRadius?;
    }
    radius ??= BorderRadius.circular(6.r);

    final EdgeInsetsGeometry? resolvedPadding =
        padding ?? searchBar.padding?.resolve(states);

    final fg = textColor ?? textStyle?.color ?? theme.colorScheme.onSurface;
    final hintClr = hintColor ?? hintStyle?.color;
    final icon = iconColor ?? hintClr ?? fg;

    return Material(
      color: bg,
      elevation: elev,
      borderRadius: radius,
      child: Padding(
        padding: resolvedPadding ?? EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedSearch01,
              color: icon,
              size: 20.r,
            ),
            SizedBox(width: 12.w),
            Expanded(
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
                  hintStyle: hintStyle,
                  contentPadding: EdgeInsets.symmetric(vertical: 20.h),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: onVoiceTap,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 8.h,
                ),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedMic01,
                  color: icon,
                  size: 20.r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
