import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/core/utils/constants/api_constants.dart';
import 'package:movura/core/utils/constants/strings.dart';
import 'package:movura/core/utils/extensions/routing_extension.dart';

import '../routing/arguments_model.dart';

class PosterCard extends StatelessWidget {
  const PosterCard({
    super.key,
    this.height,
    this.width,
    this.shadowColor,
    this.elevation,
    this.titleStyle,
    this.subTextStyle,
    this.subCardElevation,
    this.border,
    this.mediaModel,
    this.subCardColor,
    this.subCardBorder,
    this.mediaType,
    this.showRating = true,
    this.showMediaType = true,
    this.maxLines,
  });

  final double? height;
  final double? width;
  final Color? shadowColor;
  final double? elevation;
  final TextStyle? titleStyle;
  final TextStyle? subTextStyle;
  final double? subCardElevation;
  final Color? subCardColor;
  final double? border;
  final double? subCardBorder;
  final PosterModel? mediaModel;
  final String? mediaType;
  final bool? showRating;
  final bool? showMediaType;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final cardRadius = border ?? 18;

    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Strings.detailsScreen,
          ArgumentsModel(
            mediaType: mediaModel?.mediaType ?? mediaType ?? "movie",
            mediaId: mediaModel!.id,
          ),
        );
      },
      child: Card(
        elevation: elevation ?? 10,
        shadowColor: shadowColor ?? Colors.white,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        child: SizedBox(
          width: width?.w ?? 220.w,
          height: height?.h ?? 310.h,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(cardRadius),
                child: CachedNetworkImage(
                  imageUrl:
                      (mediaModel?.posterPath != null &&
                          mediaModel!.posterPath!.isNotEmpty)
                      ? "${ApiConstants.imageBaseUrl}${mediaModel!.posterPath}"
                      : "",
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => Container(
                    color: const Color(0xFF2C2938),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.movie_creation_outlined,
                          size: 40.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "No Poster Available",
                          style: Styles.font16SimiBoldPlatinumGray,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(2.0.r),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(subCardBorder ?? 10),
                    ),
                    elevation: subCardElevation ?? 8,
                    color:
                        subCardColor ?? Color(0xFF2C2938).withValues(alpha: .7),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.w,
                      ),
                      child: Text(
                        mediaModel?.title ??
                            mediaModel?.name ??
                            "Unknown Title",
                        style: titleStyle ?? Styles.font17BoldIceBlueMontserrat,
                        overflow: TextOverflow.ellipsis,
                        maxLines: maxLines ?? 1,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(2.0.r),
                  child: showMediaType == true
                      ? Card(
                          elevation: subCardElevation ?? 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              subCardBorder ?? 10,
                            ),
                          ),
                          color:
                              subCardColor ??
                              Color(0xFF2C2938).withValues(alpha: .7),
                          child: Padding(
                            padding: EdgeInsets.all(5.0.r),
                            child: Text(
                              mediaModel?.mediaType ?? mediaType ?? "N/A",
                              style:
                                  subTextStyle ??
                                  Styles.font16SimiBoldPlatinumGray,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.topRight,
                child: showRating == true
                    ? Padding(
                        padding: EdgeInsets.all(2.0.r),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              subCardBorder ?? 10,
                            ),
                          ),
                          color:
                              subCardColor ??
                              Color(0xFF2C2938).withValues(alpha: .7),
                          elevation: subCardElevation ?? 10,
                          child: Padding(
                            padding: EdgeInsets.all(5.0.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  mediaModel?.voteAverage != null
                                      ? "${mediaModel!.voteAverage!.toStringAsFixed(1)} "
                                      : "0.0",
                                  style:
                                      subTextStyle ??
                                      Styles.font16SimiBoldPlatinumGray,
                                ),
                                Icon(
                                  Icons.star_purple500_outlined,
                                  size: 18.sp,
                                  color:
                                      subTextStyle?.color ??
                                      Styles.font16SimiBoldPlatinumGray.color,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
