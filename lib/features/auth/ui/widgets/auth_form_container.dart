import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';

class AuthFormContainer extends StatelessWidget {
  const AuthFormContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.trueBlack.withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: AppSpacing.symmetric(horizontal: AppSpacing.l, vertical: 20),
            decoration: BoxDecoration(
              color: AppColors.onyxBlack.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: AppColors.pureWhite.withValues(alpha: 0.05),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
