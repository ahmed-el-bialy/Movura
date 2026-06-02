import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/utils/extensions/runtime_formatter.dart';
import '../../../../../core/utils/helpers/spacing.dart';
import '../../../data/models/about_model.dart';

class IdentificationCard extends StatelessWidget {
  const IdentificationCard({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
              height: 150.h,
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
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    bottom: 8.h,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          model.title,
                          style: Styles.font17BoldIceBlueMontserrat.copyWith(
                            fontSize: 23.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        verticalSpacing(6),
                        Row(
                          children: [
                            Text(
                              " Movie • ${model.language} • ${model.runtime.runtimeFormatter()} ",
                              style: Styles.font16SimiBoldPlatinumGray.copyWith(
                                fontSize: 14.sp,
                              ),
                            ),
                            horizontalSpacing(5.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: model.adultContent
                                    ? AppColors.softRed
                                    : AppColors.coolGray.withValues(alpha: 0.1),

                                borderRadius: BorderRadius.circular(4.r),
                                border: Border.all(
                                  color: model.adultContent
                                      ? AppColors.softRed
                                      : AppColors.coolGray.withValues(
                                          alpha: 0.4,
                                        ),

                                  width: 0.8,
                                ),
                              ),
                              child: Text(
                                model.adultContent ? "18+" : "PG",
                                style: TextStyle(
                                  color: model.adultContent
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
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                        child: Container(
                          height: 30.h,
                          width: 85.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.r),
                            color: AppColors.pureWhite.withValues(alpha: 0.07),

                            border: Border.all(
                              color: AppColors.pureWhite.withValues(
                                alpha: 0.15,
                              ),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.star_purple500_sharp,
                                size: 16.sp,
                                color: AppColors.neonCyan,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                model.rating.toStringAsFixed(1),
                                style: Styles.font20SimiBoldNeonCyanManrope
                                    .copyWith(fontSize: 15.sp),
                              ),
                              Text(
                                " / 10 ",
                                style: Styles.font13BoldNeonCyanSora.copyWith(
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
