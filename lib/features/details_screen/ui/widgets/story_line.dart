import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/features/details_screen/data/models/main_details_model.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class StoryLine extends StatefulWidget {
  const StoryLine({super.key, required this.model});

  final MainDetailsModel model;

  @override
  State<StoryLine> createState() => _StoryLineState();
}

class _StoryLineState extends State<StoryLine> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Card(
        color: AppColors.onyxBlack.withValues(alpha: .7),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "STORYLINE",
                style: Styles.font13NeonCyanBoldSora.copyWith(
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w900,
                ),
              ),

              verticalSpacing(12),

              LayoutBuilder(
                builder: (context, constraints) {
                  final textPainter = TextPainter(
                    text: TextSpan(
                      text: widget.model.overview,
                      style: Styles.font14IceBlueBoldMontserrat.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: Weights.simiBold,
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                    ),
                    maxLines: 3,
                    textDirection: TextDirection.ltr,
                  )..layout(maxWidth: constraints.maxWidth);

                  final isTextLong = textPainter.didExceedMaxLines;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.model.overview,
                        style: Styles.font14IceBlueBoldMontserrat.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontWeight: FontWeight.normal,
                          fontSize: 14.sp,
                          height: 1.5,
                        ),
                        maxLines: isExpanded ? null : 3,
                        overflow: isExpanded
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                      ),

                      if (isTextLong)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Text(
                              isExpanded ? "Read Less" : "Read More",
                              style: Styles.font13NeonCyanBoldSora.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),

              verticalSpacing(14),

              if (widget.model.genres.isNotEmpty)
                SizedBox(
                  height: 36.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: widget.model.genres.length,
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
                            splashColor: AppColors.neonCyan.withValues(
                              alpha: .2,
                            ),
                            highlightColor: AppColors.neonCyan.withValues(
                              alpha: .1,
                            ),
                            borderRadius: BorderRadius.circular(16.r),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14.w),
                                child: Text(
                                  widget.model.genres[index].name,
                                  style: Styles.font12platinumGrayMedium
                                      .copyWith(
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
        ),
      ),
    );
  }
}
