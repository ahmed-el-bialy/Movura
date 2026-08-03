import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';

class EmptySectionMessage extends StatelessWidget {
  const EmptySectionMessage({
    super.key,
    required this.icon,
    required this.title,
    this.subTitle,
    this.showIcon = true,
    this.heightPage = 300,
  });

  final IconData icon;
  final String title;
  final String? subTitle;
  final bool showIcon;
  final int? heightPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightPage?.h,
      width: double.infinity,
      padding: AppSpacing.horizontal(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showIcon)
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: AppColors.neonBlue.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.neonBlue, size: 48.sp),
            ),
          AppSpacing.verticalSpacing(showIcon ? 20 : 0),
          Text(
            title,
            style: TextStyles.font20SemiBoldNeonBlueManrope.copyWith(
              color: AppColors.iceBlue,
              fontSize: 18.sp,
            ),
            textAlign: TextAlign.center,
          ),
          if (subTitle != null) ...[
            AppSpacing.verticalSpacing(AppSpacing.s),
            Text(
              subTitle!,
              style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                color: AppColors.coolGray.withValues(alpha: 0.8),
                fontSize: 13.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
