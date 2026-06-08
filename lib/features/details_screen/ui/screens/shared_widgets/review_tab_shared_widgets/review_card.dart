import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/core/utils/constants/api_constants.dart';
import 'package:movura/core/utils/extensions/date_extension.dart';
import 'package:movura/core/utils/helpers/spacing.dart';
import 'package:movura/core/widgets/read_more_text.dart';

import '../../../../data/models/shared_models/review_model.dart';
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
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 10.w,
            vertical: 8.h,
          ),
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
                          imageUrl: model.userDetails.avatarPath != null
                              ? "${ApiConstants.imageBaseUrl}${model.userDetails.avatarPath}"
                              : ApiConstants.actorImageError,
                        ),
                      ),
                    ),
                    horizontalSpacing(10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.author,
                          style: Styles.font14PureWhiteManrope,
                        ),
                        CustomRatingBar(rating: 10),
                      ],
                    ),
                    Spacer(flex: 1),
                    Text(
                      model.createdAt.toTimeAgo(),
                      style: Styles.font12CoolGrayManrope,
                    ),
                  ],
                ),
              ),
              ReadMoreText(content: model.content),
            ],
          ),
        ),
      ),
    );
  }
}
