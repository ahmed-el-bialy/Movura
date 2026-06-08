import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/utils/extensions/rating_formatter.dart';

class CustomRatingBar extends StatelessWidget {
  final double rating;

  const CustomRatingBar({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating.toFiveStarRating(),
      itemCount: 5,
      itemSize: 10.r,
      unratedColor: AppColors.darkSlateGray,
      itemPadding: EdgeInsets.symmetric(horizontal: 1.0.w),
      itemBuilder: (context, index) =>
          const Icon(Icons.star, color: AppColors.neonCyan),
    );
  }
}
