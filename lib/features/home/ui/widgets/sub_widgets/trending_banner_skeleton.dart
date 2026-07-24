import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class TrendingBannerSkeleton extends StatelessWidget {
  const TrendingBannerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.onyxBlack,
      highlightColor: AppColors.slateGray.withValues(alpha: 0.1),
      child: Container(
        height: 420.h,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
    );
  }
}
