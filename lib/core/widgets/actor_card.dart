import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/utils/constants/api_constants.dart';

import '../models/actor_model.dart';

class ActorCard extends StatelessWidget {
  const ActorCard({super.key, required this.actor});

  final ActorModel actor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          actor.actorImage != null
              ? ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(20),
                  child: CachedNetworkImage(
                    imageUrl:
                        "${ApiConstants.imageBaseUrl}${actor.actorImage!}",
                    fit: BoxFit.cover,
                    width: 130.w,
                    height: 160.w,
                    alignment: Alignment.topCenter,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.person, color: Colors.white),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: ApiConstants.actorImageError,
                    fit: BoxFit.cover,
                    width: 130.w,
                    height: 160.w,
                    alignment: Alignment.topCenter,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.person, color: Colors.white),
                  ),
                ),

          Padding(
            padding: EdgeInsets.only(
              top: 12.h,
              left: 10.w,
              right: 10.w,
              bottom: 4.w,
            ),
            child: Text(
              actor.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.font13BoldNeonBlueSora,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              top: 5.h,
              left: 10.w,
              right: 10.w,
              bottom: 4.w,
            ),
            child: Text(
              actor.character,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.font11BoldIceBlueMontserrat.copyWith(
                fontWeight: FontWeight.normal,
                color: AppColors.platinumGray,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
            child: Text(
              actor.job,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.font11BoldIceBlueMontserrat,
            ),
          ),
        ],
      ),
    );
  }
}
