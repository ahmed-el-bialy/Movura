import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class SortToggleChip extends StatelessWidget {
  const SortToggleChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: AppSpacing.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.neonBlue.withValues(alpha: 0.15)
              : AppColors.onyxBlack.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? AppColors.neonBlue
                : AppColors.coolGray.withValues(alpha: 0.1),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? Icons.check_circle_rounded : Icons.sort_rounded,
              size: 16.sp,
              color: isSelected ? AppColors.neonBlue : AppColors.coolGray,
            ),
            AppSpacing.horizontalSpacing(10),
            Text(
              label,
              style: TextStyles.font14RegularPureWhiteManrope.copyWith(
                color: isSelected
                    ? AppColors.neonBlue
                    : AppColors.pureWhite.withValues(alpha: 0.7),
                fontSize: 12.sp,
                fontWeight: isSelected ? Weights.extraBold : Weights.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
