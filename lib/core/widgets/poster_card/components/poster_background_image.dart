import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movura/core/widgets/loading/app_shimmer.dart';

import '../../../constants/api_constants.dart';
import '../../../models/poster_model.dart';
import 'error_poster_image.dart';

class PosterBackgroundImage extends StatelessWidget {
  const PosterBackgroundImage({
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
        placeholder: (context, url) =>
            const ShimmerBox(width: double.infinity, height: double.infinity),
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
