import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/extensions/runtime_list_extension.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/features/details/data/models/tv_models/about_tv_series_model.dart';

class TvAdditionalData extends StatelessWidget {
  const TvAdditionalData({super.key, required this.model});

  final AboutTvSeriesModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Column(
        children: [
          SizedBox(
            height: 125.h,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          color: AppColors.coolGray,
                          size: 23.sp,
                        ),
                        Text(
                          "Runtime avg",
                          style: AppTextStyles.font10MediumCoolGraySora.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          model.episodeRunTime.formattedAverageRuntime,
                          style: AppTextStyles.font15MediumWhite,
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: AppColors.coolGray,
                    endIndent: 7.h,
                    indent: 7.h,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.tv_rounded,
                          color: AppColors.coolGray,
                          size: 23.sp,
                        ),
                        Text(
                          "Episodes",
                          style: AppTextStyles.font10MediumCoolGraySora.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          model.numberOfEpisodes != 0
                              ? model.numberOfEpisodes.toString()
                              : "Unknown",
                          style: AppTextStyles.font15MediumWhite,
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: AppColors.coolGray,
                    endIndent: 7.h,
                    indent: 7.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.video_library_rounded,
                          color: AppColors.coolGray,
                          size: 23.sp,
                        ),
                        Text(
                          "Seasons",
                          style: AppTextStyles.font10MediumCoolGraySora.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),

                        Text(
                          model.numberOfSeasons != 0
                              ? model.numberOfSeasons.toString()
                              : "Unknown",
                          style: AppTextStyles.font15MediumWhite,
                        ),
                      ],
                    ),
                  ),

                  verticalSpacing(5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
