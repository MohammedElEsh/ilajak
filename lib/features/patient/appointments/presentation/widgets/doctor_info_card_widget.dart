import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/shared/widgets/status_widget.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class DoctorInfoCardWidget extends StatelessWidget {
  const DoctorInfoCardWidget({super.key, required this.name, required this.specialization});
  final String name;
  final String specialization;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const StatusWidget(title: "SENIOR CONSULTANT"),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.share,
                  color: AppColors.primary,
                  size: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(name, style: AppTypography.bold24),
          SizedBox(height: 4.h),
          Text(
            specialization,
            style: AppTypography.regular14.copyWith(
              color: AppColors.fieldLabel,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              SizedBox(width: 4.w),
              Text("4.9", style: AppTypography.semiBold14),
              Text(
                " (1,248 reviews)",
                style: AppTypography.regular14.copyWith(
                  color: AppColors.fieldLabel,
                ),
              ),
              const Spacer(),
              Container(width: 1, height: 16, color: AppColors.divider),
              const Spacer(),
              const Icon(Icons.verified, color: AppColors.primary, size: 20),
              SizedBox(width: 4.w),
              Text("Verified", style: AppTypography.medium14),
            ],
          ),
        ],
      ),
    );
  }
}
