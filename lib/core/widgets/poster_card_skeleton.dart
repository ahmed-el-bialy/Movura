import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../theming/app_colors.dart';

class PosterCardSkeleton extends StatelessWidget {
  const PosterCardSkeleton({
    super.key,
    this.height,
    this.width,
    this.horizontalPadding,
    this.verticalPadding,
  });

  final double? height;
  final double? width;
  final double? horizontalPadding;
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.darkBackground,
      highlightColor: AppColors.coolGray,
      period: const Duration(milliseconds: 1200),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding?.w ?? 10.w,
          vertical: verticalPadding?.h ?? 12.h,
        ),
        child: Card(
          elevation: 10,
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Card(
            elevation: 20,
            shadowColor: AppColors.pureWhite,
            child: Container(
              width: width?.w ?? 220.w,
              height: height?.h ?? 310.h,
              color: AppColors.pureWhite,
            ),
          ),
        ),
      ),
    );
  }
}
