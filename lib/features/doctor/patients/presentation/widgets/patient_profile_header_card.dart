import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

/// The top card on Doctor Patient Profile: photo, name, the age/gender/
/// blood-type tag row, edit + share buttons, and the contact info rows.
class PatientProfileHeaderCard extends StatelessWidget {
  const PatientProfileHeaderCard({
    super.key,
    required this.name,
    required this.ageLabel,
    required this.genderLabel,
    required this.bloodTypeLabel,
    required this.phone,
    required this.email,
    required this.address,
    this.imageUrl,
    this.onEdit,
    this.onShare,
  });

  final String name;

  /// e.g. "45 Years"
  final String ageLabel;

  /// e.g. "Male"
  final String genderLabel;

  /// e.g. "Blood Type: O+"
  final String bloodTypeLabel;

  final String phone;
  final String email;
  final String address;
  final String? imageUrl;
  final VoidCallback? onEdit;
  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18.r),
            child: imageUrl != null
                ? Image.network(imageUrl!, width: 140.w, height: 140.h, fit: BoxFit.cover)
                : Container(
                    width: 140.w,
                    height: 140.h,
                    color: AppColors.secondary,
                    child: Icon(Icons.person_outline, color: AppColors.primary, size: 56.sp),
                  ),
          ),
          SizedBox(height: 14.h),
          Text(name, style: AppTypography.bold28.copyWith(color: AppColors.textPrimaryLight)),
          SizedBox(height: 10.h),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _Tag(label: ageLabel),
              _Tag(label: genderLabel),
              _Tag(label: bloodTypeLabel, filled: true),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _RoundIconButton(icon: Icons.edit_outlined, onTap: onEdit),
              SizedBox(width: 12.w),
              _RoundIconButton(icon: Icons.share_outlined, onTap: onShare),
            ],
          ),
          SizedBox(height: 18.h),
          _ContactRow(icon: Icons.call_outlined, text: phone),
          SizedBox(height: 12.h),
          _ContactRow(icon: Icons.mail_outline, text: email),
          SizedBox(height: 12.h),
          _ContactRow(icon: Icons.location_on_outlined, text: address),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, this.filled = false});

  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: filled ? AppColors.primary : AppColors.textSecondary.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: AppTypography.semiBold14.copyWith(
          color: filled ? AppColors.surfaceLight : AppColors.textPrimaryLight,
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: AppColors.primaryLight2,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20.sp),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18.sp, color: AppColors.textSecondary),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(text, style: AppTypography.regular14.copyWith(color: AppColors.textPrimaryLight)),
        ),
      ],
    );
  }
}
