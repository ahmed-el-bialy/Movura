import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/widgets/read_more_text.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/utils/helpers/spacing.dart';
import '../../../data/models/movie_models/about_model.dart';

class MovieStoryAndGenres extends StatelessWidget {
  const MovieStoryAndGenres({super.key, required this.model});

  final AboutModel model;

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

          verticalSpacing(12),

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
                        splashColor: AppColors.neonCyan.withValues(alpha: .2),
                        highlightColor: AppColors.neonCyan.withValues(
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
