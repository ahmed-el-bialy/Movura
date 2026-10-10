import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class RefinedChip extends StatelessWidget {
  const RefinedChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final ValueChanged<bool> onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onTap,
      backgroundColor: AppColors.onyxBlack.withValues(alpha: 0.4),
      selectedColor: AppColors.neonBlue.withValues(alpha: 0.25),
      labelStyle: TextStyles.font10MediumCoolGraySora.copyWith(
        color: isSelected
            ? AppColors.neonBlue
            : AppColors.pureWhite.withValues(alpha: 0.7),
        fontSize: 11.sp,
        fontWeight: isSelected ? Weights.bold : Weights.regular,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: isSelected
              ? AppColors.neonBlue.withValues(alpha: 0.7)
              : AppColors.coolGray.withValues(alpha: 0.1),
        ),
      ),
      showCheckmark: false,
      elevation: 0,
      padding: AppSpacing.symmetric(horizontal: 10, vertical: 6),
    );
  }
}
