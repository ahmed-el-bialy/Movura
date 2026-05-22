import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helper/spacing.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/features/details_screen/data/models/about_model.dart';

class ActorCard extends StatelessWidget {
  const ActorCard({super.key, required this.actor});

  final ActorModel actor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        elevation: 10,
        color: AppColors.onyxBlack,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            actor.actorImage != null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 6.h,
                      horizontal: 4.w,
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            "${ApiConstants.imageBaseUrl}${actor.actorImage!}",
                        fit: BoxFit.cover,
                        width: 120.w,
                        height: 140.w,
                        alignment: Alignment.topCenter,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 6.h,
                      horizontal: 4.w,
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://imgs.search.brave.com/N3LKytRAQg6sZ4CgMQ3XO5VPDYph_hzPT2ywP8CeGzk/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzgzL2Jj/LzhiLzgzYmM4Yjg4/Y2Y2YmM0YjRlMDRk/MTUzYTQxOGNkZTYy/LmpwZw",
                        fit: BoxFit.cover,
                        width: 120.w,
                        height: 140.w,
                        alignment: Alignment.topCenter,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
              child: Text(
                actor.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Styles.font13BoldNeonCyanSora,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                actor.character,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Styles.font10BoldIceBlueMontserrat.copyWith(
                  fontWeight: FontWeight.normal,
                  color: AppColors.platinumGray,
                ),
              ),
            ),

            verticalSpacing(8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                actor.job,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Styles.font10BoldIceBlueMontserrat,
              ),
            ),
            verticalSpacing(5),
          ],
        ),
      ),
    );
  }
}
