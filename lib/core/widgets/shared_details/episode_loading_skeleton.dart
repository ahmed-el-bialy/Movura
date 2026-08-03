import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';

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
                      padding: AppSpacing.symmetric(
                        horizontal: 20,
                        vertical: AppSpacing.l,
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
              padding: AppSpacing.symmetric(
                horizontal: AppSpacing.l,
                vertical: AppSpacing.m,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 12.h,
                    color: AppColors.pureWhite,
                  ),
                  AppSpacing.verticalSpacing(AppSpacing.s),
                  Container(
                    width: double.infinity,
                    height: 12.h,
                    color: AppColors.pureWhite,
                  ),
                  AppSpacing.verticalSpacing(AppSpacing.s),
                  Container(
                    width: 180.w,
                    height: 12.h,
                    color: AppColors.pureWhite,
                  ),
                ],
              ),
            ),
          ),
          AppSpacing.sliverVerticalSpacing(20),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppSpacing.horizontal(AppSpacing.l),
              child: SizedBox(
                height: 140.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) => Padding(
                    padding: AppSpacing.only(right: AppSpacing.m),
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
