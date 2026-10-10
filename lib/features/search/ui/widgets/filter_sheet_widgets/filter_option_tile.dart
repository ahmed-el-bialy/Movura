import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class FilterOptionTile extends StatelessWidget {
  const FilterOptionTile({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: Material(
        color: isSelected
            ? AppColors.neonBlue.withValues(alpha: 0.12)
            : AppColors.onyxBlack.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          splashColor: AppColors.neonBlue.withValues(alpha: 0.15),
          child: Container(
            padding: AppSpacing.horizontal(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isSelected
                    ? AppColors.neonBlue.withValues(alpha: 0.6)
                    : AppColors.slateGray.withValues(alpha: 0.08),
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected ? AppColors.neonBlue : AppColors.coolGray,
                  size: 18.sp,
                ),
                AppSpacing.horizontalSpacing(10),
                Expanded(
                  child: Text(
                    label,
                    style: (isSelected
                            ? TextStyles.font13BoldNeonBlueSora
                            : TextStyles.font14RegularPureWhiteManrope)
                        .copyWith(
                      fontSize: 12.sp,
                      fontWeight: isSelected
                          ? Weights.extraBold
                          : Weights.medium,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
