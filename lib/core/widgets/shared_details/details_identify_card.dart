import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class DetailsIdentifyCard extends StatelessWidget {
  const DetailsIdentifyCard({
    super.key,
    required this.title,
    this.originalTitle,
    required this.rating,
    this.tagline,
    required this.typeLabel,
    required this.year,
    required this.language,
    this.status,
    required this.isAdult,
  });

  final String title;
  final String? originalTitle;
  final double rating;
  final String? tagline;
  final String typeLabel;
  final String year;
  final String language;
  final String? status;
  final bool isAdult;

  @override
  Widget build(BuildContext context) {
    final bool showOriginalTitle =
        originalTitle != null && originalTitle != title;

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
                              title,
                              style: TextStyles.font17BoldIceBlueMontserrat
                                  .copyWith(
                                    fontSize: 22.sp,
                                    fontWeight: Weights.bold,
                                    color: AppColors.pureWhite,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (showOriginalTitle) ...[
                              AppSpacing.verticalSpacing(2),
                              Text(
                                originalTitle!,
                                style: TextStyles.font12RegularCoolGrayManrope
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
                      AppSpacing.horizontalSpacing(10),
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
                            AppSpacing.horizontalSpacing(AppSpacing.xs),
                            Text(
                              rating.toStringAsFixed(1),
                              style: TextStyles.font20SemiBoldNeonBlueManrope
                                  .copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.pureWhite,
                                    fontWeight: Weights.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (tagline != null && tagline!.isNotEmpty) ...[
                    AppSpacing.verticalSpacing(6),
                    Text(
                      '"$tagline"',
                      style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppColors.neonBlue,
                        fontWeight: Weights.medium,
                        fontSize: 13.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  AppSpacing.verticalSpacing(AppSpacing.m),
                  Divider(
                    color: AppColors.pureWhite.withValues(alpha: 0.12),
                    height: 1,
                  ),
                  AppSpacing.verticalSpacing(10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "$typeLabel  •  $year  •  ${language.toUpperCase()} ${status != null ? ' •  $status' : ''}",
                          style: TextStyles.font16SemiBoldPlatinumGray.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.platinumGray.withValues(
                              alpha: 0.9,
                            ),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AppSpacing.horizontalSpacing(10),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: isAdult
                              ? AppColors.softRed.withValues(alpha: 0.15)
                              : AppColors.coolGray.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: isAdult
                                ? AppColors.softRed.withValues(alpha: 0.5)
                                : AppColors.coolGray.withValues(alpha: 0.5),
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          isAdult ? "18+" : "PG",
                          style: TextStyle(
                            color: isAdult
                                ? AppColors.softRed
                                : AppColors.platinumGray,
                            fontSize: 10.sp,
                            fontWeight: Weights.bold,
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
