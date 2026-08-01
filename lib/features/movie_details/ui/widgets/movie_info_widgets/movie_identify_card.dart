import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/features/movie_details/data/models/about_model.dart';

class MovieIdentifyCard extends StatelessWidget {
  const MovieIdentifyCard({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    final bool showOriginalTitle =
        model.originalTitle != null && model.originalTitle != model.title;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: AppColors.pureWhite.withValues(alpha: 0.07),
                border: Border.all(
                  color: AppColors.pureWhite.withValues(alpha: 0.15),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.title ?? 'Unknown',
                              style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                                fontSize: 23.sp,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (showOriginalTitle) ...[
                              verticalSpacing(4),
                              Text(
                                model.originalTitle!,
                                style: TextStyles.font12CoolGrayManrope.copyWith(
                                  color: AppColors.platinumGray.withValues(alpha: 0.7),
                                  fontSize: 13.sp,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                      horizontalSpacing(10),
                      Container(
                        height: 30.h,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                          color: AppColors.pureWhite.withValues(alpha: 0.07),
                          border: Border.all(
                            color: AppColors.pureWhite.withValues(alpha: 0.15),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star_purple500_sharp, size: 16.sp, color: AppColors.neonBlue),
                            const SizedBox(width: 4),
                            Text(
                              (model.rating ?? 0.0).toStringAsFixed(1),
                              style: TextStyles.font20SimiBoldNeonBlueManrope.copyWith(fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpacing(12),
                  Row(
                    children: [
                      Text(
                        " Movie • ${model.language?.toUpperCase() ?? 'EN'} • ${model.status ?? 'Released'} ",
                        style: TextStyles.font16SimiBoldPlatinumGray.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                      horizontalSpacing(5.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: (model.adultContent ?? false)
                              ? AppColors.softRed
                              : AppColors.coolGray.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color: (model.adultContent ?? false)
                                ? AppColors.softRed
                                : AppColors.coolGray.withValues(alpha: 0.4),
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          (model.adultContent ?? false) ? "18+" : "PG",
                          style: TextStyles.font10BoldCoolGray.copyWith(
                            color: (model.adultContent ?? false)
                                ? AppColors.softRed
                                : AppColors.platinumGray,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
