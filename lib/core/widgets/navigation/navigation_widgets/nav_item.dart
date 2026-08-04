import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.activeIcon,
    this.inActiveIcon,
    required this.isActive,
    required this.onTap,
  });

  final IconData activeIcon;
  final IconData? inActiveIcon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.neonBlue.withValues(alpha: .2),
      highlightColor: AppColors.transparent,
      borderRadius: BorderRadius.circular(20.r),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: AppSpacing.symmetric(horizontal: 16, vertical: 10),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: Icon(
            isActive ? activeIcon : inActiveIcon ?? activeIcon,
            key: ValueKey<bool>(isActive),
            size: 26.sp,
            color: isActive ? AppColors.neonBlue : AppColors.slateGray,
          ),
        ),
      ),
    );
  }
}
