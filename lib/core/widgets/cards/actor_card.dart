import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/models/actor_model.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class ActorCard extends StatelessWidget {
  const ActorCard({super.key, required this.actor});

  final ActorModel actor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (actor.id != null) {
          context.pushNamed(
            RouteNames.personDetailsScreen,
            arguments: actor.id,
          );
        }
      },
      child: Padding(
        padding: AppSpacing.all(6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            actor.actorImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: CachedNetworkImage(
                      imageUrl:
                          "${ApiConstants.imageBaseUrl}${actor.actorImage!}",
                      fit: BoxFit.cover,
                      width: 130.w,
                      height: 160.w,
                      alignment: Alignment.topCenter,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.person, color: AppColors.pureWhite),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: CachedNetworkImage(
                      imageUrl: ApiConstants.actorImageError,
                      fit: BoxFit.cover,
                      width: 130.w,
                      height: 160.w,
                      alignment: Alignment.topCenter,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.person, color: AppColors.pureWhite),
                    ),
                  ),
            Padding(
              padding: AppSpacing.only(
                top: AppSpacing.m,
                left: 10,
                right: 10,
                bottom: AppSpacing.xs,
              ),
              child: Text(
                actor.name ?? "Unknown",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.font13BoldNeonBlueSora,
              ),
            ),
            Padding(
              padding: AppSpacing.only(
                top: 5,
                left: 10,
                right: 10,
                bottom: AppSpacing.xs,
              ),
              child: Text(
                actor.character ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.font11BoldIceBlueMontserrat.copyWith(
                  fontWeight: Weights.regular,
                  color: AppColors.platinumGray,
                ),
              ),
            ),
            Padding(
              padding: AppSpacing.symmetric(horizontal: AppSpacing.s, vertical: 5),
              child: Text(
                actor.job ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.font11BoldIceBlueMontserrat,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
