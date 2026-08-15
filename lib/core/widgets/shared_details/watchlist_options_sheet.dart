import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class WatchlistOptionsSheet extends StatefulWidget {
  const WatchlistOptionsSheet({super.key});

  @override
  State<WatchlistOptionsSheet> createState() => _WatchlistOptionsSheetState();
}

class _WatchlistOptionsSheetState extends State<WatchlistOptionsSheet> {
  // Four fixed library collections as requested
  final Map<String, bool> _states = {
    'Favorites': false,
    'To Watch': false,
    'Watched': false,
    'Watch It Now': false,
  };

  void _toggleState(String label, Color color) {
    setState(() {
      _states[label] = !(_states[label] ?? false);
    });

    final isAdded = _states[label]!;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isAdded ? Icons.check_circle_rounded : Icons.info_outline_rounded,
              color: AppColors.pureWhite,
              size: 20.sp,
            ),
            AppSpacing.horizontalSpacing(AppSpacing.m),
            Text(
              isAdded ? 'Added to $label' : 'Removed from $label',
              style: TextStyles.font14BoldIceBlueMontserrat.copyWith(
                color: AppColors.pureWhite,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
        backgroundColor: isAdded
            ? color.withValues(alpha: 0.95)
            : AppColors.softRed.withValues(alpha: 0.95),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: AppSpacing.all(AppSpacing.l),
        elevation: 10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.only(
        left: AppSpacing.xl,
        top: AppSpacing.m,
        right: AppSpacing.xl,
        bottom: AppSpacing.xxl,
      ),
      decoration: BoxDecoration(
        color: AppColors.charcoalBlack,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.trueBlack.withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 45.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: AppColors.slateGray.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          AppSpacing.verticalSpacing(AppSpacing.xl),
          Row(
            children: [
              Text(
                'Save to Library',
                style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                  fontSize: 20.sp,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close_rounded,
                  color: AppColors.coolGray.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          AppSpacing.verticalSpacing(AppSpacing.xs),
          Text(
            'Quickly organize items into your library collections',
            style: TextStyles.font12RegularCoolGrayManrope.copyWith(
              color: AppColors.coolGray.withValues(alpha: 0.8),
            ),
          ),
          AppSpacing.verticalSpacing(AppSpacing.xxl),
          Row(
            children: [
              _ActionItem(
                activeIcon: Icons.favorite_rounded,
                inactiveIcon: Icons.favorite_border_rounded,
                label: 'Favorites',
                isSelected: _states['Favorites']!,
                onTap: () => _toggleState('Favorites', AppColors.softRed),
                color: AppColors.softRed,
              ),
              _ActionItem(
                activeIcon: Icons.bookmark_rounded,
                inactiveIcon: Icons.bookmark_outline_rounded,
                label: 'To Watch',
                isSelected: _states['To Watch']!,
                onTap: () => _toggleState('To Watch', AppColors.neonBlue),
                color: AppColors.neonBlue,
              ),
              _ActionItem(
                activeIcon: Icons.check_circle_rounded,
                inactiveIcon: Icons.check_circle_outline_rounded,
                label: 'Watched',
                isSelected: _states['Watched']!,
                onTap: () => _toggleState('Watched', AppColors.tealCyan),
                color: AppColors.tealCyan,
              ),
              _ActionItem(
                activeIcon: Icons.play_circle_fill_rounded,
                inactiveIcon: Icons.play_circle_outline_rounded,
                label: 'Watch It Now',
                isSelected: _states['Watch It Now']!,
                onTap: () => _toggleState('Watch It Now', AppColors.amberGold),
                color: AppColors.amberGold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
    required this.onTap,
    required this.color,
    required this.isSelected,
  });

  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: AppSpacing.horizontal(AppSpacing.xs),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: AppSpacing.vertical(AppSpacing.l),
            decoration: BoxDecoration(
              color: isSelected
                  ? color.withValues(alpha: 0.12)
                  : AppColors.onyxBlack.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected
                    ? color.withValues(alpha: 0.5)
                    : AppColors.pureWhite.withValues(alpha: 0.05),
                width: 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.1),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSelected ? activeIcon : inactiveIcon,
                  color: isSelected
                      ? color
                      : AppColors.coolGray.withValues(alpha: 0.8),
                  size: 24.sp,
                ),
                AppSpacing.verticalSpacing(AppSpacing.s),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font10BoldCoolGray.copyWith(
                    color: isSelected
                        ? AppColors.pureWhite
                        : AppColors.coolGray.withValues(alpha: 0.6),
                    fontSize: 9.sp,
                    fontWeight: isSelected ? Weights.bold : Weights.medium,
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
