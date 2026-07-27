import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/read_more_text.dart';
import 'package:movura/core/widgets/section_title.dart';

import '../../../data/models/about_model.dart';

class MovieStoryAndGenres extends StatelessWidget {
  const MovieStoryAndGenres({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            sectionName: "STORYLINE",
            titleStyle: TextStyles.font20SimiBoldPlatinumGray.copyWith(
              fontSize: 16.sp,
            ),
            horizontalPadding: 1,
            verticalPadding: 2,
          ),
          verticalSpacing(5),
          ReadMoreText(content: model.overview ?? ''),
          verticalSpacing(10),
          SectionTitle(
            sectionName: "GENRES",
            titleStyle: TextStyles.font20SimiBoldPlatinumGray.copyWith(
              fontSize: 16.sp,
            ),
            horizontalPadding: 1,
            verticalPadding: 2,
          ),
          verticalSpacing(10),
          if (model.genres != null)
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: model.genres!.map((genre) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.onyxBlack.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: AppColors.slateGray.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Text(
                    genre.name,
                    style: TextStyles.font12MediumPlatinumGray,
                  ),
                );
              }).toList(),
            ),

          verticalSpacing(10),
        ],
      ),
    );
  }
}
