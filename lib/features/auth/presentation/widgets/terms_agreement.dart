import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_strings.dart';

class TermsAgreement extends StatelessWidget {
  const TermsAgreement({
    super.key,
    this.onRegisterTap,
    this.isChecked = false,
    this.onChanged,
    this.onTermsTap,
    this.onPrivacyTap,
  });

  final VoidCallback? onRegisterTap;
  final bool isChecked;
  final ValueChanged<bool?>? onChanged;
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24.w,
          width: 24.w,
          child: Checkbox(
            value: isChecked,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: theme.textTheme.labelLarge?.copyWith(
                color: colors.onSurfaceVariant,
              ),
              children: [
                TextSpan(text: AppStrings.authTermsAgree.tr()),
                TextSpan(
                  text: AppStrings.authTermsTermsOfService.tr(),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colors.primary,
                    decorationColor: colors.primary,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onTermsTap,
                ),
                TextSpan(text: AppStrings.authTermsAnd.tr()),
                TextSpan(
                  text: AppStrings.authTermsPrivacyPolicy.tr(),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colors.primary,
                    decorationColor: colors.primary,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onPrivacyTap,
                ),
                TextSpan(text: AppStrings.authTermsMedicalData.tr()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
