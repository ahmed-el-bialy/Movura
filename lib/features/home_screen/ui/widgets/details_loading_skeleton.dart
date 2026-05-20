import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/colors.dart';

class DetailsLoadingSkeleton extends StatelessWidget {
  const DetailsLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = AppColors.onyxBlack.withValues(alpha: 0.8);
    final highlightColor = Colors.grey[800]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 530.h,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(color: AppColors.iceBlue),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 140.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                Container(
                  width: 180.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                SizedBox(width: 10.w),

                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),

          verticalSpacing(20),

          Padding(
            padding: EdgeInsets.all(6.0.r),
            child: SizedBox(
              height: 210.h,
              width: 3000.w,
              child: Card(
                elevation: 0,

                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 80.w, height: 14.h, color: Colors.black),
                      verticalSpacing(15),

                      Container(
                        width: double.infinity,
                        height: 12.h,
                        color: Colors.black,
                      ),
                      verticalSpacing(8),

                      Container(
                        width: double.infinity,
                        height: 12.h,
                        color: Colors.black,
                      ),
                      verticalSpacing(8),

                      Container(
                        width: 180.w,
                        height: 12.h,
                        color: Colors.black,
                      ),
                      const Spacer(),

                      SizedBox(
                        height: 35.h,
                        child: Row(
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: Container(
                                width: 60.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          verticalSpacing(10),

          Divider(color: AppColors.onyxBlack, thickness: 2),

          verticalSpacing(20),
        ],
      ),
    );
  }
}
