import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

/// A single "Recent Patients" avatar + name, used in a horizontal list
/// on Doctor Home. [imageUrl] is optional — falls back to a placeholder
/// person icon until patient photos are wired up to the backend.
class RecentPatientAvatar extends StatelessWidget {
  const RecentPatientAvatar({
    super.key,
    required this.name,
    this.imageUrl,
    this.highlighted = false,
    this.onTap,
  });

  final String name;
  final String? imageUrl;
  final bool highlighted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: highlighted ? Border.all(color: AppColors.primary, width: 2) : null,
            ),
            padding: EdgeInsets.all(highlighted ? 2.r : 0),
            child: CircleAvatar(
              radius: 30.r,
              backgroundColor: AppColors.secondary,
              backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
              child: imageUrl == null
                  ? Icon(Icons.person_outline, color: AppColors.primary, size: 26.sp)
                  : null,
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: 64.w,
            child: Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.regular13.copyWith(color: AppColors.textPrimaryLight),
            ),
          ),
        ],
      ),
    );
  }
}
