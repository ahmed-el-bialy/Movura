import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class ProfileCollectionTile extends StatelessWidget {
  const ProfileCollectionTile({
    super.key,
    required this.title,
    this.count,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final int? count;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.only(bottom: 12),
      child: Material(
        color: AppColors.onyxBlack.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppSpacing.l),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.l),
          child: Container(
            padding: AppSpacing.all(AppSpacing.l),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.l),
              border: Border.all(color: color.withValues(alpha: 0.1), width: 1),
            ),
            child: Row(
              children: [
                Container(
                  padding: AppSpacing.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 22.sp),
                ),
                AppSpacing.horizontalSpacing(AppSpacing.l),
                Text(
                  title,
                  style: TextStyles.font14RegularPureWhiteManrope.copyWith(
                    fontWeight: Weights.semiBold,
                  ),
                ),
                const Spacer(),
                if (count != null)
                  Text(
                    '$count',
                    style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.coolGray,
                    ),
                  ),
                AppSpacing.horizontalSpacing(AppSpacing.s),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.coolGray.withValues(alpha: 0.5),
                  size: 14.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
