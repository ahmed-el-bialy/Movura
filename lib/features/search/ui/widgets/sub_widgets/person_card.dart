import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/poster_model.dart';

import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/constants/api_constants.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({super.key, required this.person, this.height, this.width});

  final PosterModel person;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
      child: SizedBox(
        width: width?.w ?? 220.w,
        height: height?.h ?? 310.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: person.profilePath != null
                  ? "${ApiConstants.imageBaseUrl}${person.profilePath}"
                  : "",
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                color: const Color(0xFF2C2938),
                child: Icon(Icons.person, size: 50.sp),
              ),
            ),

            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(2.r),
                child: Card(
                  color: const Color(0xFF2C2938).withValues(alpha: .8),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    child: Text(
                      person.name ?? "Unknown",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font17BoldIceBlueMontserrat,
                    ),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(2.r),
                child: Card(
                  color: const Color(0xFF2C2938).withValues(alpha: .8),
                  child: Padding(
                    padding: EdgeInsets.all(5.r),
                    child: Text(
                      "Person",
                      style: AppTextStyles.font16SimiBoldPlatinumGray,
                    ),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(2.r),
                child: Card(
                  color: const Color(0xFF2C2938).withValues(alpha: .8),
                  child: Padding(
                    padding: EdgeInsets.all(5.r),
                    child: Text(
                      person.knownForDepartment ?? "Unknown",
                      style: AppTextStyles.font16SimiBoldPlatinumGray,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
