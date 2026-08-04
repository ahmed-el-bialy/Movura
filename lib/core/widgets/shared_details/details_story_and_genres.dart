import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/core/widgets/layout/read_more_text.dart';
import 'package:movura/core/widgets/layout/section_title.dart';

class DetailsStoryAndGenres extends StatelessWidget {
  const DetailsStoryAndGenres({
    super.key,
    required this.overview,
    required this.genres,
    this.onGenreTap,
  });

  final String overview;
  final List<dynamic>? genres;
  final void Function(int id, String name)? onGenreTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.horizontal(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.verticalSpacing(20),
          SectionTitle(
            sectionName: "STORYLINE",
            titleStyle: TextStyles.font20SemiBoldPlatinumGray.copyWith(
              fontSize: 16.sp,
            ),
            horizontalPadding: 0,
            verticalPadding: 0,
          ),
          AppSpacing.verticalSpacing(AppSpacing.s),
          ReadMoreText(content: overview),
          AppSpacing.verticalSpacing(AppSpacing.xl),
          SectionTitle(
            sectionName: "GENRES",
            titleStyle: TextStyles.font20SemiBoldPlatinumGray.copyWith(
              fontSize: 16.sp,
            ),
            horizontalPadding: 0,
            verticalPadding: 0,
          ),
          AppSpacing.verticalSpacing(AppSpacing.m),
          if (genres != null)
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: genres!.map((genre) {
                return InkWell(
                  onTap: () {
                    if (onGenreTap != null) {
                      onGenreTap!(genre.id, genre.name);
                    }
                  },
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    padding: AppSpacing.symmetric(
                      horizontal: 14,
                      vertical: AppSpacing.s,
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
                        fontWeight: Weights.semiBold,
                        color: AppColors.platinumGray.withValues(alpha: 0.9),
                      ),
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
