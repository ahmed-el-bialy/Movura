import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/core/theming/app_colors.dart';

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
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12.r),
        splashColor: AppColors.neonBlue.withValues(alpha: .2),
        child: Padding(
          padding: EdgeInsets.all(padding?.r ?? 8.r),
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
