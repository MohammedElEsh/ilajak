import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/health/presentation/widgets/health_card_widget.dart';
import 'package:ilajak/features/patient/health/presentation/widgets/health_view_banner.dart';

class HealthView extends StatelessWidget {
  const HealthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w).copyWith(bottom: 68.h),
      child: Scaffold(
        appBar: AppTopBar(
          leadingWidget: CircleAvatar(
            radius: 20.r,
            backgroundImage: const AssetImage(AppAssets.profileImage),
          ),
          titleWidget: Text(
            AppStrings.homeAppBarTitle.tr(),
            style: AppTypography.bold28.copyWith(color: AppColors.primary),
          ),
          actionWidget: Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedSearch01,
                size: 24.sp,
                color: AppColors.primary,
                strokeWidth: 1.5,
              ),
              SizedBox(width: 8.w),
              HugeIcon(
                icon: HugeIcons.strokeRoundedFilterMail,
                size: 24.sp,
                color: AppColors.primary,
                strokeWidth: 1.5,
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 24.h),
                const HealthViewBanner(),
                SizedBox(height: 24.h),
                HealthCardWidget(
                  title: 'Lipid Profile',
                  subtitle: 'Oct 24, 2023 • General Checkup',
                  icon: Icons.science_outlined,
                  status: 'High',
                  statusColor: AppColors.error,
                  statusBackgroundColor: AppColors.redTileIconBackgroundColor,
                  labValue: 'TOTAL CHOLESTEROL',
                  value: '245',
                  valueColor: AppColors.error,
                  unit: 'mg/dL',
                  normalRange: '125 - 200',
                  onViewDetailsPressed: () {},
                  onDownloadPressed: () {},
                ),
                SizedBox(height: 16.h),
                HealthCardWidget(
                  // Complete Blood Count
                  title: 'Complete Blood Count',
                  subtitle: 'Oct 12, 2023 • Routine Screening',
                  icon: Icons.bloodtype_outlined,
                  status: 'Normal',
                  statusColor: AppColors.success,
                  statusBackgroundColor: AppColors.greenBg,
                  labValue: 'HEMOGLOBIN',
                  value: '12.5',
                  valueColor: AppColors.primary,
                  unit: 'g/dL',
                  normalRange: '13.5 - 17.5',
                  onViewDetailsPressed: () {},
                  onDownloadPressed: () {},
                ),
                SizedBox(height: 16.h),
                HealthCardWidget(
                  // Vitamin D, 25-Hydroxy
                  title: 'Vitamin D, 25-Hydroxy',
                  subtitle: 'Sep 30, 2023 • Deficiency Check',
                  icon: Icons.wb_sunny_outlined,
                  status: 'High',
                  statusColor: AppColors.success,
                  statusBackgroundColor: AppColors.greenBg,
                  labValue: 'Result Value',
                  value: '15',
                  valueColor: AppColors.primary,
                  unit: 'ng/dL',
                  normalRange: '30 - 100',
                  onViewDetailsPressed: () {},
                  onDownloadPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
