import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/theming/app_colors.dart';

class SeasonLoadingSkeleton extends StatelessWidget {
  const SeasonLoadingSkeleton({
    super.key,
    required this.tvTitle,
    required this.seasonName,
  });

  final String tvTitle;
  final String seasonName;

  @override
  Widget build(BuildContext context) {
    final baseColor = AppColors.onyxBlack.withValues(alpha: 0.8);
    final highlightColor = Colors.grey[800]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 340.h,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(color: AppColors.iceBlue),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      child: Container(
                        height: 90.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 12.h,
                    color: Colors.white,
                  ),
                  verticalSpacing(8),
                  Container(
                    width: double.infinity,
                    height: 12.h,
                    color: Colors.white,
                  ),
                  verticalSpacing(8),
                  Container(width: 200.w, height: 12.h, color: Colors.white),
                ],
              ),
            ),
          ),
          sliverVerticalSpacing(16),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                child: Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ),
              childCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}
