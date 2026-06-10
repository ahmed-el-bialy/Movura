import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/utils/constants/api_constants.dart';
import '../../../../../core/utils/extensions/routing_extension.dart';
import '../../../data/models/movie_models/about_model.dart';
import 'movie_identify_card.dart';

class MovieMainDetails extends StatelessWidget {
  const MovieMainDetails({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: "${ApiConstants.imageBaseUrl}${model.posterPath}",
            fit: BoxFit.cover,
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.05),
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.2),
                  Colors.black,
                ],
              ),
            ),
          ),

          Positioned(
            top: 40.h,
            right: 16.w,
            child: SizedBox(
              width: 44.r,
              height: 44.r,
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.r),
                ),
                color: AppColors.onyxBlack.withValues(alpha: .9),
                child: InkWell(
                  borderRadius: BorderRadius.circular(22.r),
                  splashColor: AppColors.neonCyan.withValues(alpha: .4),
                  onTap: () {},
                  child: Center(
                    child: Icon(
                      Icons.favorite_border,
                      color: AppColors.neonCyan,
                      size: 22.r,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 40.h,
            left: 16.w,
            child: SizedBox(
              width: 44.r,
              height: 44.r,
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.r),
                ),
                color: AppColors.onyxBlack.withValues(alpha: .95),
                child: InkWell(
                  borderRadius: BorderRadius.circular(22.r),
                  splashColor: AppColors.neonCyan.withValues(alpha: .4),
                  onTap: () {
                    context.pop();
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.neonCyan,
                        size: 20.r,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          MovieIdentifyCard(model: model),
        ],
      ),
    );
  }
}