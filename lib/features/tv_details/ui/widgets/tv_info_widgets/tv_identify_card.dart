import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extensions/status_display_extension.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../data/about_tv_series_model.dart';

class TvIdentifyCard extends StatelessWidget {
  const TvIdentifyCard({super.key, required this.model});

  final AboutTvSeriesModel model;

  @override
  Widget build(BuildContext context) {
    final bool showOriginalTitle =
        model.originalTitle != null && model.originalTitle != model.title;

    final String firstAirYear =
        (model.startAirDate != null && model.startAirDate!.length >= 4)
        ? model.startAirDate!.substring(0, 4)
        : '';

    final String statusStr = model.status?.statusDisplay ?? 'N/A';

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(18.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: AppColors.pureWhite.withValues(alpha: 0.08),
                border: Border.all(
                  color: AppColors.pureWhite.withValues(alpha: 0.18),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.trueBlack.withValues(alpha: 0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.title ?? 'Unknown',
                              style: TextStyles.font17BoldIceBlueMontserrat
                                  .copyWith(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.pureWhite,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (showOriginalTitle) ...[
                              verticalSpacing(2),
                              Text(
                                model.originalTitle!,
                                style: TextStyles.font12CoolGrayManrope
                                    .copyWith(
                                      color: AppColors.platinumGray.withValues(
                                        alpha: 0.8,
                                      ),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColors.onyxBlack.withValues(alpha: 0.6),
                          border: Border.all(
                            color: AppColors.neonBlue.withValues(alpha: 0.4),
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 16.sp,
                              color: AppColors.neonBlue,
                            ),
                            horizontalSpacing(4),
                            Text(
                              (model.rating ?? 0.0).toStringAsFixed(1),
                              style: TextStyles.font20SimiBoldNeonBlueManrope
                                  .copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.pureWhite,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (model.tagline != null && model.tagline!.isNotEmpty) ...[
                    verticalSpacing(6),
                    Text(
                      '"${model.tagline!}"',
                      style: TextStyles.font12CoolGrayManrope.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppColors.neonBlue,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  verticalSpacing(12),
                  Divider(
                    color: AppColors.pureWhite.withValues(alpha: 0.12),
                    height: 1,
                  ),
                  verticalSpacing(10),
                  Row(
                    children: [
                      Text(
                        "TV Series  •  ${firstAirYear.isNotEmpty ? '$firstAirYear  •  ' : ''}${model.language?.toUpperCase() ?? 'EN'}  •  $statusStr",
                        style: TextStyles.font16SimiBoldPlatinumGray.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.platinumGray.withValues(alpha: 0.9),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: (model.adultContent ?? false)
                              ? AppColors.softRed.withValues(alpha: 0.15)
                              : AppColors.coolGray.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: (model.adultContent ?? false)
                                ? AppColors.softRed.withValues(alpha: 0.5)
                                : AppColors.coolGray.withValues(alpha: 0.5),
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
