import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.label,
    required this.activeIcon,
    this.inActiveIcon,
    required this.isActive,
    required this.onTap,
  });

  final String label;
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
        curve: Curves.easeOutCubic,
        padding: AppSpacing.symmetric(
          horizontal: isActive ? 14 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.neonBlue.withValues(alpha: 0.15)
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: isActive
              ? Border.all(
            color: AppColors.neonBlue.withValues(alpha: 0.3),
            width: 1,
          )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
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
                isActive ? activeIcon : (inActiveIcon ?? activeIcon),
                key: ValueKey<bool>(isActive),
                size: 22.sp,
                color: isActive ? AppColors.neonBlue : AppColors.slateGray,
              ),
            ),
            if (isActive) ...[
              AppSpacing.horizontalSpacing(6),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: isActive ? 1.0 : 0.0,
                child: Text(
                  label,
                  style: TextStyles.font13MediumNeonBlue.copyWith(
                    color: AppColors.neonBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
