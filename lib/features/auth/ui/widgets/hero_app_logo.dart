import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theming/app_colors.dart';

class HeroAppLogo extends StatelessWidget {
  const HeroAppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'app_logo',
      child: Container(
        padding: EdgeInsets.all(10.r),
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
