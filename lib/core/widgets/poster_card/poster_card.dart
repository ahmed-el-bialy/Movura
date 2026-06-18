import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/utils/constants/api_constants.dart';
import 'package:movura/core/utils/constants/strings.dart';
import 'package:movura/core/utils/extensions/routing_extension.dart';
import 'package:movura/core/widgets/poster_card/sub_widgets/bottom_lef_sub_card.dart';
import 'package:movura/core/widgets/poster_card/sub_widgets/error_poster_image.dart';
import 'package:movura/core/widgets/poster_card/sub_widgets/top_lef_sub_card.dart';
import 'package:movura/core/widgets/poster_card/sub_widgets/top_right_sub_card.dart';

import '../../routing/arguments_model.dart';

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
          AppStrings.detailsScreen,
          ArgumentsModel(
            mediaType: mediaModel?.mediaType ?? mediaType ?? "movie",
            mediaId: mediaModel!.id,
          ),
        );
      },
      child: Card(
        elevation: elevation ?? 11,
        shadowColor: shadowColor ?? Colors.grey[350],
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
              BackGroundImage(
                cardRadius: cardRadius,
                mediaModel: mediaModel,
                titleStyle: titleStyle,
              ),

              BottomLeftSubCard(
                subCardBorder: subCardBorder,
                subCardElevation: subCardElevation,
                subCardColor: subCardColor,
                mediaModel: mediaModel,
                titleStyle: titleStyle,
                maxLines: maxLines,
              ),

              TopLeftSubCard(
                showMediaType: showMediaType,
                subCardElevation: subCardElevation,
                subCardBorder: subCardBorder,
                subCardColor: subCardColor,
                mediaModel: mediaModel,
                mediaType: mediaType,
                subTextStyle: subTextStyle,
              ),

              TopRightSubCard(
                showRating: showRating,
                subCardBorder: subCardBorder,
                subCardColor: subCardColor,
                subCardElevation: subCardElevation,
                mediaModel: mediaModel,
                subTextStyle: subTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackGroundImage extends StatelessWidget {
  const BackGroundImage({
    super.key,
    required this.cardRadius,
    required this.mediaModel,
    required this.titleStyle,
  });

  final double cardRadius;
  final PosterModel? mediaModel;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(cardRadius),
      child: CachedNetworkImage(
        imageUrl:
            (mediaModel?.posterPath != null &&
                mediaModel!.posterPath!.isNotEmpty)
            ? "${ApiConstants.imageBaseUrl}${mediaModel!.posterPath}"
            : (mediaModel?.profilePath != null &&
                  mediaModel!.profilePath!.isNotEmpty)
            ? "${ApiConstants.imageBaseUrl}${mediaModel!.profilePath}"
            : "",
        fit: BoxFit.fill,
        errorWidget: (context, url, error) => mediaModel?.mediaType == "person"
            ? CachedNetworkImage(
                imageUrl: ApiConstants.actorImageError,
                fit: BoxFit.cover,
              )
            : ErrorPosterImage(titleStyle: titleStyle),
      ),
    );
  }
}
