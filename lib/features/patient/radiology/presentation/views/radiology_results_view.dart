import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/radiology/presentation/widgets/lab_pending_result_card.dart';
import 'package:ilajak/features/patient/radiology/presentation/widgets/radiology_card_info.dart';
import 'package:ilajak/features/patient/radiology/presentation/widgets/radiology_list_view_builder.dart';

class RadiologyResultsView extends StatelessWidget {
  const RadiologyResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        leadingWidget: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 24,
            color: AppColors.primary,
          ),
        ),
        title: AppStrings.radiologyTitle.tr(),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 36.h),
                Text(
                  AppStrings.radiologyResults.tr(),
                  style: AppTypography.bold28.copyWith(
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  AppStrings.radiologyReviewText.tr(),
                  style: AppTypography.regular16.copyWith(
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                SizedBox(height: 24.h),
                // Radiology types ListView
                const RadiologyListViewBuilder(),
                SizedBox(height: 32.h),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const RadiologyCardInfo();
                  },
                  itemCount: 2,
                ),

                const LabPendingResultCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
