import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/theming/app_colors.dart';

import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/constants/api_constants.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({super.key, required this.person});

  final PosterModel person;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(RouteNames.personDetailsScreen, arguments: person.id);
      },
      child: Card(
        elevation: 8,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: person.profilePath != null
                  ? "${ApiConstants.imageBaseUrl}${person.profilePath}"
                  : "",
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                color: AppColors.onyxBlack,
                child: Icon(Icons.person_rounded, size: 40.sp, color: AppColors.slateGray),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.name ?? "Unknown",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font14BoldIceBlueMontserrat,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    person.knownForDepartment ?? "Person",
                    style: TextStyles.font10MediumCoolGraySora.copyWith(
                      color: AppColors.neonBlue.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
