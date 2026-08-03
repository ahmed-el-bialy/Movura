import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/extensions/date_extension.dart';
import 'package:movura/core/models/review_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/layout/read_more_text.dart';

import 'custom_rating_bar.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.model});

  final ReviewModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.onyxBlack,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 20.sp,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: model.authorDetails?.avatarPath != null
                              ? "${ApiConstants.imageBaseUrl}${model.authorDetails?.avatarPath}"
                              : ApiConstants.actorImageError,
                        ),
                      ),
                    ),
                    AppSpacing.horizontalSpacing(10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.author!,
                            style: TextStyles.font14RegularPureWhiteManrope,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          model.authorDetails?.rating == null
                              ? AppSpacing.verticalSpacing(AppSpacing.s)
                              : CustomRatingBar(
                                  rating: model.authorDetails!.rating!,
                                ),
                        ],
                      ),
                    ),
                    AppSpacing.horizontalSpacing(15),
                    Text(
                      model.createdAt!.toTimeAgo(),
                      style: TextStyles.font12RegularCoolGrayManrope,
                    ),
                  ],
                ),
              ),
              ReadMoreText(content: model.content!),
            ],
          ),
        ),
      ),
    );
  }
}
