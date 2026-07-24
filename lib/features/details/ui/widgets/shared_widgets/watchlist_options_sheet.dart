import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

class WatchlistOptionsSheet extends StatelessWidget {
  const WatchlistOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
      decoration: BoxDecoration(
        color: AppColors.charcoalBlack,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.slateGray.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          verticalSpacing(24),
          Text(
            'Add to My Lists',
            style: AppTextStyles.font17BoldIceBlueMontserrat.copyWith(
              fontSize: 18.sp,
            ),
          ),
          verticalSpacing(8),
          Text(
            'Save this content to your personalized collections',
            style: AppTextStyles.font12CoolGrayManrope,
          ),
          verticalSpacing(32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ActionItem(
                icon: Icons.bookmark_outline_rounded,
                label: 'Watchlist',
                onTap: () {
                  // TODO: Implement Watchlist logic
                  Navigator.pop(context);
                },
                color: AppColors.neonBlue,
              ),
              _ActionItem(
                icon: Icons.check_circle_outline_rounded,
                label: 'Watched',
                onTap: () {
                  // TODO: Implement Watched logic
                  Navigator.pop(context);
                },
                color: AppColors.tealCyan,
              ),
              _ActionItem(
                icon: Icons.favorite_border_rounded,
                label: 'Favorite',
                onTap: () {
                  // TODO: Implement Favorites logic
                  Navigator.pop(context);
                },
                color: AppColors.deepCrimson,
              ),
              _ActionItem(
                icon: Icons.add_box_outlined,
                label: 'Create List',
                onTap: () {
                  // TODO: Implement custom list creation
                  Navigator.pop(context);
                },
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
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppColors.onyxBlack,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            splashColor: color.withValues(alpha: 0.2),
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(icon, color: color, size: 28.sp),
            ),
          ),
        ),
        verticalSpacing(8),
        Text(
          label,
          style: AppTextStyles.font10BoldCoolGray.copyWith(
            color: Colors.white70,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }
}
