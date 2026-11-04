import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.only(
        left: AppSpacing.xl,
        top: 60,
        right: AppSpacing.xl,
        bottom: 30,
      ),
      decoration: BoxDecoration(
        color: AppColors.onyxBlack.withValues(alpha: 0.3),
        border: Border(
          bottom: BorderSide(
            color: AppColors.pureWhite.withValues(alpha: 0.05),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: AppSpacing.all(AppSpacing.s),
            decoration: BoxDecoration(
              color: AppColors.neonBlue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.neonBlue.withValues(alpha: 0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonBlue.withValues(alpha: 0.15),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Image.asset(AppConstants.appLogo, height: 50.h),
          ),
          AppSpacing.verticalSpacing(AppSpacing.l),
          Text(
            AppConstants.appName.toUpperCase(),
            style: TextStyles.font24SemiBoldNeonBlueManrope.copyWith(
              letterSpacing: 6,
              fontSize: 22.sp,
              fontWeight: Weights.black,
              shadows: [
                Shadow(
                  color: AppColors.neonBlue.withValues(alpha: 0.5),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          AppSpacing.verticalSpacing(AppSpacing.xs),
          Container(
            padding: AppSpacing.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.neonBlue.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: AppColors.neonBlue.withValues(alpha: 0.1),
              ),
            ),
            child: Text(
              'ULTIMATE CINEMA GUIDE',
              style: TextStyles.font10MediumCoolGraySora.copyWith(
                letterSpacing: 1.5,
                color: AppColors.neonBlue.withValues(alpha: 0.8),
                fontSize: 8.sp,
                fontWeight: Weights.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
