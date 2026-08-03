import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.neonBlue.withValues(alpha: .5),
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Padding(
        padding: AppSpacing.all(AppSpacing.s),
        child: Icon(
          icon,
          size: 28.sp,
          color: isActive ? AppColors.neonBlue : AppColors.slateGray,
        ),
      ),
    );
  }
}
