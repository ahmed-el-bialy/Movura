import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/widgets/poster_card_skeleton.dart';
import 'package:shimmer/shimmer.dart';

import '../theming/app_colors.dart';

class SkeletonPostersListLoading extends StatelessWidget {
  const SkeletonPostersListLoading({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.darkBackground,
      highlightColor: AppColors.onyxBlack,
      period: const Duration(milliseconds: 1200),
      child: SizedBox(
        height: height == null ? 340.h : height!.h,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return PosterCardSkeleton(height: height, width: width);
          },
        ),
      ),
    );
  }
}
