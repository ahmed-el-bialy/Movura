import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

import 'watchlist_toggle_indicator.dart';

class WatchlistCollectionRow extends StatelessWidget {
  const WatchlistCollectionRow({
    super.key,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
    required this.subtitle,
    required this.isSelected,
    required this.isLoading,
    required this.color,
    required this.onTap,
    this.isLast = false,
  });

  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;
  final String subtitle;
  final bool isSelected;
  final bool isLoading;
  final Color color;
  final VoidCallback? onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r),
            splashColor: color.withValues(alpha: 0.08),
            highlightColor: color.withValues(alpha: 0.04),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              padding: AppSpacing.symmetric(horizontal: 4, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: isSelected
                    ? color.withValues(alpha: 0.06)
                    : Colors.transparent,
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    width: 44.r,
                    height: 44.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? color.withValues(alpha: 0.18)
                          : AppColors.onyxBlack.withValues(alpha: 0.6),
                      border: Border.all(
                        color: isSelected
                            ? color.withValues(alpha: 0.5)
                            : AppColors.slateGray.withValues(alpha: 0.15),
                        width: 1.5,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.25),
                                blurRadius: 12,
                                spreadRadius: 0,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      isSelected ? activeIcon : inactiveIcon,
                      color: isSelected
                          ? color
                          : AppColors.coolGray.withValues(alpha: 0.6),
                      size: 20.sp,
                    ),
                  ),
                  AppSpacing.horizontalSpacing(AppSpacing.l),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyles.font14RegularPureWhiteManrope
                              .copyWith(
                                fontWeight: isSelected
                                    ? Weights.bold
                                    : Weights.semiBold,
                                color: isSelected
                                    ? AppColors.pureWhite
                                    : AppColors.platinumGray,
                              ),
                        ),
                        AppSpacing.verticalSpacing(2),
                        Text(
                          subtitle,
                          style: TextStyles.font12RegularCoolGrayManrope
                              .copyWith(
                                fontSize: 11.sp,
                                color: AppColors.coolGray.withValues(
                                  alpha: 0.55,
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                  WatchlistToggleIndicator(
                    isSelected: isSelected,
                    isLoading: isLoading,
                    color: color,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!isLast)
          Divider(
            color: AppColors.slateGray.withValues(alpha: 0.08),
            height: 1,
            indent: 60.w,
          ),
      ],
    );
  }
}
