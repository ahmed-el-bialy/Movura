import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/widgets/read_more_text.dart';
import 'package:movura/features/details/data/models/tv_models/about_tv_series_model.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/utils/helpers/spacing.dart';

class TvStoryAndGenres extends StatelessWidget {
  const TvStoryAndGenres({super.key, required this.model});

  final AboutTvSeriesModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "STORYLINE",
            style: Styles.font13BoldNeonCyanSora.copyWith(
              letterSpacing: 1.5,
              fontWeight: FontWeight.w900,
            ),
          ),

          verticalSpacing(10),
          model.tagline != null && model.tagline!.isNotEmpty
              ? Center(
                  child: Text(
                    ' "${model.tagline!}"',
                    style: Styles.font11BoldIceBlueMontserrat.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                )
              : const SizedBox.shrink(),

          model.tagline != null && model.tagline!.isNotEmpty
              ? verticalSpacing(6)
              : const SizedBox.shrink(),
          ReadMoreText(content: model.overview),

          verticalSpacing(14),

          if (model.genres.isNotEmpty)
            SizedBox(
              height: 36.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: model.genres.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.onyxBlack.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        splashColor: AppColors.neonBlue.withValues(alpha: .2),
                        highlightColor: AppColors.neonBlue.withValues(
                          alpha: .1,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Text(
                              model.genres[index].name,
                              style: Styles.font12MediumPlatinumGray.copyWith(
                                fontSize: 13.sp,
                                color: AppColors.platinumGray,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
