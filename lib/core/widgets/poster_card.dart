import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helper/routing_extension.dart';
import 'package:movura/core/helper/strings.dart';
import 'package:movura/core/networking/api_constants.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/features/home_screen/data/model/poster_model.dart';

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
    this.media,
    this.subCardColor,
    this.subCardBorder,
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
  final PosterModel? media;

  @override
  Widget build(BuildContext context) {
    final cardRadius = border ?? 18;

    return GestureDetector(
      onTap: (){
        context.pushNamed(Strings.detailsScreen, media?.id);
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
                  imageUrl: (media?.posterPath != null &&
                      media!.posterPath.isNotEmpty)
                      ? "${ApiConstants.imageBaseUrl}${media!.posterPath}"
                      : "",
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) =>
                      Container(
                        color: const Color(0xFF2C2938),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.movie_creation_outlined, size: 40.sp,
                                color: Colors.grey),
                            SizedBox(height: 8.h),
                            Text("No Poster Available",
                                style: Styles.font16platinumGraySimiBold),
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
                        borderRadius: BorderRadius.circular(subCardBorder ?? 10)),
                    elevation: subCardElevation ?? 8,
                    color: subCardColor ??
                        Color(0xFF2C2938).withValues(alpha: .9),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.w, vertical: 4.w),
                      child: Text(
                        media?.title ?? media?.name ?? "Unknown Title",
                        style: titleStyle ?? Styles.font17IceBlueBoldMontserrat,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(2.0.r),
                  child: Card(
                    elevation: subCardElevation ?? 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(subCardBorder ?? 10)),
                    color: subCardColor ??
                        Color(0xFF2C2938).withValues(alpha: .9),
                    child: Padding(
                      padding: EdgeInsets.all(5.0.r),
                      child: Text(
                        media?.mediaType ?? "N/A",
                        style: subTextStyle ?? Styles.font16platinumGraySimiBold,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.topRight,
                child: Padding(
                  padding: EdgeInsets.all(2.0.r),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(subCardBorder ?? 10)),
                    color: subCardColor ??
                        Color(0xFF2C2938).withValues(alpha: .9),
                    elevation: subCardElevation ?? 10,
                    child: Padding(
                      padding: EdgeInsets.all(5.0.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            media?.voteAverage != null
                                ? media!.voteAverage.toStringAsFixed(1)
                                : "0.0",
                            style: subTextStyle ??
                                Styles.font16platinumGraySimiBold,
                          ),
                          Icon(
                            Icons.star_purple500_outlined,
                            size: 18.sp,
                            color: subTextStyle?.color ?? Styles
                                .font16platinumGraySimiBold.color,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}