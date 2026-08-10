import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';

class ProfileImageAvatar extends StatelessWidget {
  const ProfileImageAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize = 80.r;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 3.r),
          ),
          child: ClipOval(
            child: Image.asset(
              AppAssets.profileImage,
              width: avatarSize,
              height: avatarSize,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 2.r,
          right: 2.r,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(6.r),
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 16.r,
            ),
          ),
        ),
      ],
    );
  }
}
