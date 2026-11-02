import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.icon,
    required this.label,
    this.subtitle,
    required this.onTap,
    this.trailing,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppSpacing.only(bottom: AppSpacing.xs),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.pureWhite.withValues(alpha: 0.03),
            width: 0.8,
          ),
        ),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        onTap: onTap,
        contentPadding: AppSpacing.symmetric(
          horizontal: AppSpacing.l,
          vertical: AppSpacing.s,
        ),
        leading: Container(
          padding: AppSpacing.all(10),
          decoration: BoxDecoration(
            color: (iconColor ?? AppColors.neonBlue).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: (iconColor ?? AppColors.neonBlue).withValues(alpha: 0.1),
            ),
          ),
          child: Icon(
            icon,
            color: iconColor ?? AppColors.platinumGray.withValues(alpha: 0.8),
            size: 22.sp,
          ),
        ),
        title: Text(
          label,
          style: TextStyles.font14RegularPureWhiteManrope.copyWith(
            fontWeight: Weights.bold,
            color: AppColors.pureWhite.withValues(alpha: 0.95),
            fontSize: 14.sp,
          ),
        ),
        subtitle: subtitle != null
            ? Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  subtitle!,
                  style: TextStyles.font10MediumCoolGraySora.copyWith(
                    color: AppColors.coolGray.withValues(alpha: 0.6),
                    fontSize: 10.sp,
                    letterSpacing: 0.3,
                  ),
                ),
              )
            : null,
        trailing:
            trailing ??
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.neonBlue.withValues(alpha: 0.2),
              size: 12.sp,
            ),
      ),
    );
  }
}
