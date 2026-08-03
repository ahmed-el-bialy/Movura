import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

class EpisodeNavigationButton extends StatelessWidget {
  const EpisodeNavigationButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    required this.isLeft,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.onyxBlack,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        splashColor: AppColors.neonBlue.withValues(alpha: 0.1),
        child: Container(
          padding: AppSpacing.all(AppSpacing.l),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.pureWhite.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            mainAxisAlignment: isLeft
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              if (isLeft) ...[
                Icon(icon, color: AppColors.neonBlue, size: 20.sp),
                AppSpacing.horizontalSpacing(AppSpacing.s),
              ],
              Text(
                label,
                style: TextStyles.font13BoldNeonBlueSora.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.iceBlue,
                ),
              ),
              if (!isLeft) ...[
                AppSpacing.horizontalSpacing(AppSpacing.s),
                Icon(icon, color: AppColors.neonBlue, size: 20.sp),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
