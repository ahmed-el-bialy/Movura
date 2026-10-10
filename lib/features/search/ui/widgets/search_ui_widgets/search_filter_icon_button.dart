import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';

class FilterIconButton extends StatelessWidget {
  const FilterIconButton({
    super.key,
    required this.onTap,
    required this.isFiltered,
  });

  final VoidCallback onTap;
  final bool isFiltered;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: AppSpacing.all(12),
        decoration: BoxDecoration(
          color: AppColors.charcoalBlack,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isFiltered
                ? AppColors.neonBlue
                : AppColors.coolGray.withValues(alpha: 0.2),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              isFiltered ? Icons.filter_alt_rounded : Icons.filter_alt_outlined,
              color: isFiltered ? AppColors.neonBlue : AppColors.coolGray,
              size: 24.sp,
            ),
            if (isFiltered)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: const BoxDecoration(
                    color: AppColors.amberGold,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
