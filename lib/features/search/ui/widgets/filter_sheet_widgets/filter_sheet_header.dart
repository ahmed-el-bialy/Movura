import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class FilterSectionHeader extends StatelessWidget {
  const FilterSectionHeader({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.neonBlue.withValues(alpha: 0.8),
          size: 16.sp,
        ),
        AppSpacing.horizontalSpacing(AppSpacing.m),
        Text(
          title,
          style: TextStyles.font10BoldCoolGray.copyWith(
            letterSpacing: 2.0,
            color: AppColors.coolGray.withValues(alpha: 0.6),
            fontWeight: Weights.black,
          ),
        ),
        AppSpacing.horizontalSpacing(AppSpacing.m),
        Expanded(
          child: Container(
            height: 0.5,
            color: AppColors.neonBlue.withValues(alpha: 0.15),
          ),
        ),
      ],
    );
  }
}

class HeaderCloseButton extends StatelessWidget {
  const HeaderCloseButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.onyxBlack.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        padding: AppSpacing.all(4),
        constraints: const BoxConstraints(),
        icon: Icon(Icons.close_rounded, color: AppColors.coolGray, size: 20.sp),
      ),
    );
  }
}
