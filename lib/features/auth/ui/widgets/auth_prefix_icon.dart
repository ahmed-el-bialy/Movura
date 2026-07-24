import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';

class AuthPrefixIcon extends StatelessWidget {
  const AuthPrefixIcon({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Icon(
        icon,
        size: 22.sp,
        color: AppColors.neonBlue.withValues(alpha: 0.7),
      ),
    );
  }
}
