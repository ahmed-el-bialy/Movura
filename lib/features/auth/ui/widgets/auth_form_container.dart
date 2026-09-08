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
            color: AppColors.trueBlack.withValues(alpha: 0.55),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: AppColors.neonBlue.withValues(alpha: 0.06),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: AppSpacing.symmetric(horizontal: 20, vertical: 24),
            decoration: BoxDecoration(
              color: AppColors.jetBlack.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: AppColors.neonBlue.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
