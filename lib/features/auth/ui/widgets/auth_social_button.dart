import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';

class AuthSocialButton extends StatelessWidget {
  const AuthSocialButton({
    super.key,
    required this.logoPath,
    required this.backgroundColor,
    required this.onTap,
  });

  final String logoPath;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.horizontal(AppSpacing.s),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15.r),
          child: Ink(
            padding: AppSpacing.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: AppColors.pureWhite.withValues(alpha: 0.1),
              ),
            ),
            child: Image.asset(logoPath, width: 18.w, height: 18.h),
          ),
        ),
      ),
    );
  }
}
