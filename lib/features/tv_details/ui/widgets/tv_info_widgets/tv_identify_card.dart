import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/status_display_extension.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/helpers/spacing.dart';
import '../../../data/about_tv_series_model.dart';

class TvIdentifyCard extends StatelessWidget {
  const TvIdentifyCard({super.key, required this.model});

  final AboutTvSeriesModel model;

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
              padding: EdgeInsets.all(18.r),
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
                          color: AppColors.onyxBlack.withValues(alpha: 0.6),
                          border: Border.all(
                            color: AppColors.neonBlue.withValues(alpha: 0.3),
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star_rounded, size: 16.sp, color: AppColors.neonBlue),
                            const SizedBox(width: 4),
                            Text(
                              (model.rating ?? 0.0).toStringAsFixed(1),
                              style: TextStyles.font20SimiBoldNeonBlueManrope.copyWith(
                                fontSize: 14.sp,
                                color: AppColors.pureWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (model.tagline != null && model.tagline!.isNotEmpty) ...[
                    verticalSpacing(10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(color: AppColors.neonBlue, width: 2)),
                      ),
                      child: Text(
                        model.tagline!,
                        style: TextStyles.font12CoolGrayManrope.copyWith(
                          fontStyle: FontStyle.italic,
                          color: AppColors.iceBlue.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                  verticalSpacing(12),
                  Row(
                    children: [
                      Text(
                        " TV Series • ${model.language?.toUpperCase() ?? 'EN'} • ${(model.status?.statusDisplay ?? 'N/A')} ",
                        style: TextStyles.font16SimiBoldPlatinumGray.copyWith(
                          fontSize: 13.sp,
                          color: AppColors.platinumGray.withValues(alpha: 0.8),
                        ),
                      ),
                      horizontalSpacing(8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: (model.adultContent ?? false)
                              ? AppColors.softRed.withValues(alpha: 0.1)
                              : AppColors.coolGray.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: (model.adultContent ?? false)
                                ? AppColors.softRed.withValues(alpha: 0.4)
                                : AppColors.coolGray.withValues(alpha: 0.4),
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          (model.adultContent ?? false) ? "18+" : "PG",
                          style: TextStyle(
                            color: (model.adultContent ?? false)
                                ? AppColors.softRed
                                : AppColors.platinumGray,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
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
