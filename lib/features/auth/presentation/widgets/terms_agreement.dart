import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';

class TermsAgreement extends StatelessWidget {
  const TermsAgreement({
    super.key,
    this.onRegisterTap,
  });

  final VoidCallback? onRegisterTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        children: [
          TextSpan(
            text: AppStrings.authTermsFirstPart.tr(),
          ),
          TextSpan(
            text: AppStrings.authTermsLink.tr(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
              decoration: TextDecoration.underline,
              decorationColor: theme.colorScheme.primary,
            ),
            recognizer: TapGestureRecognizer()..onTap = onRegisterTap,
          ),
          TextSpan(
            text: AppStrings.authTermsSecondPart.tr(),
          ),
        ],
      ),
    );
  }
}
