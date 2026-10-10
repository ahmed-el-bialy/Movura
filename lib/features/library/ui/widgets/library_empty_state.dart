import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';

class LibraryEmptyState extends StatelessWidget {
  const LibraryEmptyState({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 90.r,
              height: 90.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.onyxBlack.withValues(alpha: 0.5),
                border: Border.all(
                  color: AppColors.slateGray.withValues(alpha: 0.1),
                  width: 1.5,
                ),
              ),
              child: Icon(
                icon,
                size: 40.sp,
                color: AppColors.slateGray.withValues(alpha: 0.4),
              ),
            ),
            AppSpacing.verticalSpacing(AppSpacing.xl),
            Text(
              'Nothing in $title yet',
              style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                color: AppColors.slateGray,
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalSpacing(AppSpacing.s),
            Text(
              'Browse movies and shows, then tap the bookmark icon to add them here.',
              textAlign: TextAlign.center,
              style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                color: AppColors.coolGray.withValues(alpha: 0.6),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
