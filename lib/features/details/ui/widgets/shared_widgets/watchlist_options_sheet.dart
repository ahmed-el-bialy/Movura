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
          verticalSpacing(24),
          _ListOptionTile(
            icon: Icons.bookmark_outline_rounded,
            label: 'Watchlist',
            onTap: () {
              // TODO: Implement Watchlist logic
              Navigator.pop(context);
            },
            color: AppColors.neonBlue,
          ),
          verticalSpacing(12),
          _ListOptionTile(
            icon: Icons.check_circle_outline_rounded,
            label: 'Mark as Watched',
            onTap: () {
              // TODO: Implement Watched logic
              Navigator.pop(context);
            },
            color: AppColors.tealCyan,
          ),
          verticalSpacing(12),
          _ListOptionTile(
            icon: Icons.favorite_border_rounded,
            label: 'Add to Favorites',
            onTap: () {
              // TODO: Implement Favorites logic
              Navigator.pop(context);
            },
            color: AppColors.deepCrimson,
          ),
          verticalSpacing(12),
          _ListOptionTile(
            icon: Icons.add_box_outlined,
            label: 'Create Custom List',
            onTap: () {
              // TODO: Implement custom list creation
              Navigator.pop(context);
            },
            color: AppColors.amberGold,
          ),
        ],
      ),
    );
  }
}

class _ListOptionTile extends StatelessWidget {
  const _ListOptionTile({
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
    return Material(
      color: AppColors.onyxBlack,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: color.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24.sp),
              horizontalSpacing(16),
              Text(
                label,
                style: AppTextStyles.font14PureWhiteManrope.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.add_rounded,
                color: AppColors.coolGray,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
