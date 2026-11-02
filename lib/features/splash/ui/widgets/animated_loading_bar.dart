import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';

class AnimatedLoadingBar extends StatelessWidget {
  const AnimatedLoadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    final barWidth = 140.w;

    return Center(
      child: SizedBox(
        width: barWidth,
        height: 2.h,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.darkSlateGray.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: const LinearGradient(
                  colors: [AppColors.darkNeonCyan, AppColors.neonBlue],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neonBlue.withValues(alpha: 0.6),
                    blurRadius: 8,
                  ),
                ],
              ),
            ).animate().custom(
              duration: 2800.ms,
              curve: Curves.easeInOut,
              builder: (_, value, child) => FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: value.clamp(0.0, 1.0),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
