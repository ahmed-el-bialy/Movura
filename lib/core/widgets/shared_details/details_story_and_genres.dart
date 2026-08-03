import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../helpers/spacing.dart';
import '../../theming/app_colors.dart';
import '../../theming/text_styles.dart';
import '../read_more_text.dart';
import '../section_title.dart';

class DetailsStoryAndGenres extends StatelessWidget {
  const DetailsStoryAndGenres({
    super.key,
    required this.overview,
    required this.genres,
  });

  final String overview;
  final List<dynamic>? genres;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpacing(20),
          SectionTitle(
            sectionName: "STORYLINE",
            titleStyle: TextStyles.font20SimiBoldPlatinumGray.copyWith(
              fontSize: 16.sp,
            ),
            horizontalPadding: 0,
            verticalPadding: 0,
          ),
          verticalSpacing(8),
          ReadMoreText(content: overview),
          verticalSpacing(24),
          SectionTitle(
            sectionName: "GENRES",
            titleStyle: TextStyles.font20SimiBoldPlatinumGray.copyWith(
              fontSize: 16.sp,
            ),
            horizontalPadding: 0,
            verticalPadding: 0,
          ),
          verticalSpacing(12),
          if (genres != null)
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: genres!.map((genre) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.onyxBlack.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.neonBlue.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Text(
                    genre.name,
                    style: TextStyles.font12MediumPlatinumGray.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.platinumGray.withValues(alpha: 0.9),
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
