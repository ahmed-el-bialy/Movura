import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/widgets/loading/poster_card_skeleton.dart';

import 'package:movura/core/theming/app_colors.dart';

class SkeletonPosterGridLoading extends StatelessWidget {
  const SkeletonPosterGridLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.jetBlack,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: .57,
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 3.w,
          crossAxisCount: 3,
        ),
        itemCount: 18,
        itemBuilder: (context, index) {
          return const PosterCardSkeleton(
            verticalPadding: 0,
            horizontalPadding: 0,
          );
        },
      ),
    );
  }
}
