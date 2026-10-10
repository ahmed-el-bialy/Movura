import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class SelectionSummaryBar extends StatelessWidget {
  const SelectionSummaryBar({super.key, required this.summary});

  final String summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.symmetric(horizontal: AppSpacing.l, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.onyxBlack.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.flash_on_rounded, color: AppColors.gold, size: 14),
          AppSpacing.horizontalSpacing(AppSpacing.m),
          Expanded(
            child: Text(
              summary,
              style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                fontSize: 11.sp,
                color: AppColors.iceBlue.withValues(alpha: 0.6),
                fontWeight: Weights.bold,
                fontStyle: FontStyle.italic,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class SmallActionButton extends StatelessWidget {
  const SmallActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isSecondary = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    if (isSecondary) {
      return SizedBox(
        height: 30.h,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.softRed,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: Text(
            label,
            style: TextStyles.font14RegularPureWhiteManrope.copyWith(
              color: AppColors.softRed,
              fontWeight: Weights.black,
              fontSize: 12.sp,
            ),
          ),
        ),
      );
    }

    return Container(
      height: 30.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.neonBlue, AppColors.tealCyan],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonBlue.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyles.font17BoldTrueBlackSora.copyWith(
            fontSize: 10.sp,
            letterSpacing: 0.5,
            fontWeight: Weights.black,
          ),
        ),
      ),
    );
  }
}
