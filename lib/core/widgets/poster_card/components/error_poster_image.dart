import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

class ErrorPosterImage extends StatelessWidget {
  const ErrorPosterImage({super.key, required this.titleStyle});

  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkPurpleGray,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.movie_creation_outlined, size: 40.sp, color: AppColors.coolGray),
          SizedBox(height: 8.h),
          Text(
            "No Poster Available",
            style: titleStyle ?? TextStyles.font16SimiBoldPlatinumGray,
          ),
        ],
      ),
    );
  }
}
