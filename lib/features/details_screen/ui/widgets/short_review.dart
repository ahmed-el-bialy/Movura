import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/details_screen/data/models/main_details_model.dart';

import '../../../../core/helper/runtime_formatter.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class ShortReview extends StatelessWidget {
  const ShortReview({super.key, required this.model});

  final MainDetailsModel model;

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
                color: Colors.white.withValues(alpha: 0.07),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
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
                          style: Styles.font17IceBlueBoldMontserrat.copyWith(
                            fontSize: 23.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        verticalSpacing(6),
                        Text(
                          " Movie • ${model.language} • ${model.runtime.runtimeFormatter()} ",
                          style: Styles.font12platinumGraySimiBold.copyWith(
                            fontSize: 14.sp,
                          ),
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
                            color: Colors.white.withValues(alpha: 0.07),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.15),
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
                                style: Styles.font20NeonCyanSimiBoldManrope
                                    .copyWith(fontSize: 15.sp),
                              ),
                              Text(
                                " / 10 ",
                                style: Styles.font13NeonCyanBoldSora.copyWith(
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
