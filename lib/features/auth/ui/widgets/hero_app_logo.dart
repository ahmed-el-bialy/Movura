import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
          boxShadow: [
            BoxShadow(
              color: AppColors.neonBlue.withValues(alpha: 0.1),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Image.asset(
          AppConstants.appLogo,
          width: 82.w,
          height: 80.h,
        ),
      )
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .scale(
            duration: 2.seconds,
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.05, 1.05),
            curve: Curves.easeInOut,
          )
          .shimmer(
            duration: 3.seconds,
            color: AppColors.neonBlue.withValues(alpha: 0.1),
          ),
    );
  }
}
