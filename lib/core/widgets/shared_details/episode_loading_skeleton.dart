import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../helpers/spacing.dart';
import '../../theming/app_colors.dart';

class EpisodeLoadingSkeleton extends StatelessWidget {
  const EpisodeLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = AppColors.onyxBlack.withValues(alpha: 0.8);
    final highlightColor = AppColors.onyxBlack;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 320.h,
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
                          color: AppColors.pureWhite,
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
                    color: AppColors.pureWhite,
                  ),
                  verticalSpacing(8),
                  Container(
                    width: double.infinity,
                    height: 12.h,
                    color: AppColors.pureWhite,
                  ),
                  verticalSpacing(8),
                  Container(
                    width: 180.w,
                    height: 12.h,
                    color: AppColors.pureWhite,
                  ),
                ],
              ),
            ),
          ),
          sliverVerticalSpacing(20),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                height: 140.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
