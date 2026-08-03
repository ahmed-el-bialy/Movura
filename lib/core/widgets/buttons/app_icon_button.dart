import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.size,
    this.padding,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? size;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? AppColors.transparent,
      borderRadius: BorderRadius.circular(AppSpacing.m),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppSpacing.m),
        splashColor: AppColors.neonBlue.withValues(alpha: .2),
        child: Padding(
          padding: AppSpacing.all(padding ?? AppSpacing.s),
          child: Icon(
            icon,
            size: size?.sp ?? 24.sp,
            color: iconColor ?? AppColors.neonBlue,
          ),
        ),
      ),
    );
  }
}
