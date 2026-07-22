import 'package:flutter/material.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class RowTextButtonWidget extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onTap;
  const RowTextButtonWidget({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTypography.semiBold22.copyWith(
            color: AppColors.textPrimaryLight,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onTap,
          child: Text(
            buttonText,
            style: AppTypography.regular14.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
