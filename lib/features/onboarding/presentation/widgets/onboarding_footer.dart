import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/shared/buttons/app_button.dart';

class OnboardingFooter extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const OnboardingFooter({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: AppButton(
        label: isLast
            ? AppStrings.onboardingGetStarted.tr()
            : AppStrings.onboardingNext.tr(),
        onPressed: onNext,
        variant: AppButtonVariant.elevated,
        expanded: true,
        suffixIcon: Icon(Icons.arrow_forward_rounded),
      ),
    );
  }
}
