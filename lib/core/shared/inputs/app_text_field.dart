import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../theme/colors/app_colors.dart';

enum AppTextFieldType { text, dropdown, date }

class AppTextField<T> extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.initialValue,
    this.hint,
    this.label,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.isPassword = false,
    this.enablePasswordToggle = true,
    this.isLoading = false,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onEditingComplete,
    this.validator,
    this.errorText,
    this.cursorColor,
    this.cursorHeight,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.contentPadding,
    this.fillColor,
    this.textStyle,
    this.hintStyle,
    this.type = AppTextFieldType.text,
    this.dropdownItems,
    this.dropdownValue,
    this.onDropdownChanged,
    this.locale,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;

  final String? hint;
  final String? label;
  final String? helperText;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool enabled;
  final bool readOnly;
  final bool autofocus;

  final bool isPassword;
  final bool enablePasswordToggle;

  final bool isLoading;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;

  final int? maxLines;
  final int? minLines;
  final bool expands;

  final List<TextInputFormatter>? inputFormatters;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;

  final String? Function(String?)? validator;
  final String? errorText;

  final Color? cursorColor;
  final double? cursorHeight;
  final double cursorWidth;
  final Radius? cursorRadius;

  final EdgeInsets? contentPadding;
  final Color? fillColor;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  final AppTextFieldType type;
  final List<DropdownMenuItem<T>>? dropdownItems;
  final T? dropdownValue;
  final ValueChanged<T?>? onDropdownChanged;
  final Locale? locale;

  @override
  State<AppTextField> createState() => _AppTextFieldState<T>();
}

class _AppTextFieldState<T> extends State<AppTextField<T>> {
  late bool _obscure;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _toggleObscure() {
    setState(() => _obscure = !_obscure);
  }

  Widget? _buildSuffix() {
    if (widget.isLoading) {
      return SizedBox(
        width: 18.r,
        height: 18.r,
        child: const CupertinoActivityIndicator(radius: 9),
      );
    }

    if (widget.isPassword && widget.enablePasswordToggle) {
      return IconButton(
        onPressed: _toggleObscure,
        icon: HugeIcon(
          icon: _obscure
              ? HugeIcons.strokeRoundedViewOffSlash
              : HugeIcons.strokeRoundedView,
          size: 22.r,
          color: AppColors.fieldLabel,
        ),
      );
    }

    if (widget.type == AppTextFieldType.dropdown) {
      return HugeIcon(
        icon: HugeIcons.strokeRoundedArrowDown01,
        size: 20.r,
        color: AppColors.fieldLabel,
      );
    }

    if (widget.type == AppTextFieldType.date) {
      return HugeIcon(
        icon: HugeIcons.strokeRoundedCalendar01,
        size: 22.r,
        color: AppColors.fieldLabel,
      );
    }

    return widget.suffixIcon;
  }

  InputDecoration _buildDecoration() {
    final theme = Theme.of(context).inputDecorationTheme;
    final suffix = _buildSuffix();

    return InputDecoration(
      hintText: widget.hint,
      labelText: widget.label,
      helperText: widget.helperText,
      errorText: widget.errorText,
      prefixIcon: widget.prefixIcon != null
          ? Padding(
              padding: EdgeInsetsDirectional.only(start: 14.w, end: 8.w),
              child: widget.prefixIcon!,
            )
          : null,
      suffixIcon: suffix != null
          ? Padding(
              padding: EdgeInsetsDirectional.only(end: 8.w),
              child: suffix,
            )
          : null,
      filled: true,
      fillColor: widget.fillColor ?? theme.fillColor,
      contentPadding: widget.contentPadding ?? theme.contentPadding,
      hintStyle: widget.hintStyle ?? theme.hintStyle,
      border: theme.border,
      enabledBorder: theme.enabledBorder,
      focusedBorder: theme.focusedBorder,
      errorBorder: theme.errorBorder,
      focusedErrorBorder: theme.focusedErrorBorder,
      disabledBorder: theme.disabledBorder,
      counterText: '',
    );
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: widget.locale,
    );
    if (date != null && widget.controller != null) {
      widget.controller!.text =
          '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
      widget.onChanged?.call(widget.controller!.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == AppTextFieldType.dropdown) {
      return DropdownButtonFormField<T>(
        initialValue: widget.dropdownValue,
        items: widget.dropdownItems ?? [],
        onChanged: widget.enabled ? widget.onDropdownChanged : null,
        validator: widget.validator != null
            ? (value) => widget.validator!(value as String?)
            : null,
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedArrowDown01,
          size: 20.r,
          color: AppColors.fieldLabel,
        ),
        style:
            widget.textStyle ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
        decoration: _buildDecoration(),
      );
    }

    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      initialValue: widget.initialValue,
      obscureText: widget.isPassword ? _obscure : false,
      enabled: widget.enabled,
      readOnly: widget.readOnly || widget.type == AppTextFieldType.date,
      autofocus: widget.autofocus,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      maxLines: widget.isPassword ? 1 : (widget.maxLines ?? 1),
      minLines: widget.minLines,
      expands: widget.expands,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.type == AppTextFieldType.date ? _pickDate : widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      validator: widget.validator,
      style:
          widget.textStyle ??
          Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
      cursorColor: widget.cursorColor,
      cursorHeight: widget.cursorHeight,
      cursorWidth: widget.cursorWidth,
      cursorRadius: widget.cursorRadius,
      decoration: _buildDecoration(),
    );
  }
}
