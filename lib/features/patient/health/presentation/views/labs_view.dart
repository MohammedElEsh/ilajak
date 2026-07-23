import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/health/presentation/widgets/lab_panel_card_widget.dart';

class LabResultsView extends StatelessWidget {
  const LabResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        leadingWidget: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.sp),
        ),
        titleWidget: Text(
          'Lab Results',
          style: AppTypography.semiBold22.copyWith(
            color: AppColors.textPrimaryLight,
          ),
        ),
      ),
      // I'll get all the data from the clicable labs in the health page
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
          child: const SingleChildScrollView(
            child: Column(
              children: [
                LabPanelCardWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

