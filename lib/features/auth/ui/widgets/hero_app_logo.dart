import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/core/constants/app_constants.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';

class HeroAppLogo extends StatelessWidget {
  const HeroAppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'app_logo',
      child: Container(
        padding: AppSpacing.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.neonBlue.withValues(
            alpha: 0.05,
          ),
          border: Border.all(
            color: AppColors.neonBlue.withValues(
              alpha: 0.15,
            ),
          ),
        ),
        child: Image.asset(
          AppConstants.appLogo,
          width: 82.w,
          height: 80.h,
        ),
      ),
    );
  }
}
