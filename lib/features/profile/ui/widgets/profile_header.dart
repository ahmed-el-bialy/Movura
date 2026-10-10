import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.displayName,
    required this.email,
  });

  final String displayName;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 100.r,
            height: 100.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.onyxBlack,
              border: Border.all(
                color: AppColors.neonBlue,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonBlue.withValues(alpha: 0.2),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              Icons.person_rounded,
              size: 60.sp,
              color: AppColors.neonBlue,
            ),
          ),
          AppSpacing.verticalSpacing(AppSpacing.l),
          Text(
            displayName,
            style: TextStyles.font24SemiBoldNeonBlueManrope.copyWith(
              color: AppColors.iceBlue,
            ),
          ),
          AppSpacing.verticalSpacing(4),
          Text(
            email,
            style: TextStyles.font12RegularCoolGrayManrope.copyWith(
              color: AppColors.coolGray.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
