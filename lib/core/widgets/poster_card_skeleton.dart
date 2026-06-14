import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PosterCardSkeleton extends StatelessWidget {
  const PosterCardSkeleton({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1A1A1A),
      highlightColor: Colors.grey[700]!,
      period: const Duration(milliseconds: 1200),
      child: SizedBox(
        height: height == null ? 340.h : height!.h,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              child: Card(
                elevation: 10,
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Card(
                  elevation: 20,
                  shadowColor: Colors.white,
                  child: Container(
                    width: width?.w ?? 220.w,
                    height: height?.h ?? 310.h,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
