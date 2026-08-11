import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

/// A single entry in the Doctor "Medical Records" list for a patient.
///
/// [badge] is the small icon/glyph shown in the colored circle to the
/// left (pass an [Icon] or, for the flagged "*" mark, a plain [Text] —
/// there's no built-in Material icon that matches that glyph exactly).
///
/// The chevron rotates on tap purely as visual feedback for now — there's
/// no expanded-detail content designed yet.
// TODO(design): what should show when a record is expanded?
class MedicalRecordCard extends StatefulWidget {
  const MedicalRecordCard({
    super.key,
    required this.badge,
    required this.badgeColor,
    required this.date,
    required this.title,
    required this.doctorName,
    required this.specialty,
    this.isFlagged = false,
  });

  final Widget badge;
  final Color badgeColor;

  /// e.g. "Oct 12, 2023"
  final String date;
  final String title;
  final String doctorName;
  final String specialty;

  /// Renders the date in red instead of blue (e.g. "Acute Gastritis").
  final bool isFlagged;

  @override
  State<MedicalRecordCard> createState() => _MedicalRecordCardState();
}

class _MedicalRecordCardState extends State<MedicalRecordCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(color: widget.badgeColor, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: widget.badge,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.date,
                          style: AppTypography.semiBold14.copyWith(
                            color: widget.isFlagged ? AppColors.error : AppColors.primary,
                          ),
                        ),
                      ),
                      AnimatedRotation(
                        turns: _expanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary, size: 22.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    widget.title,
                    style: AppTypography.semiBold18.copyWith(color: AppColors.textPrimaryLight),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(Icons.person_outline, size: 14.sp, color: AppColors.textSecondary),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          '${widget.doctorName} • ${widget.specialty}',
                          style: AppTypography.regular14.copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
