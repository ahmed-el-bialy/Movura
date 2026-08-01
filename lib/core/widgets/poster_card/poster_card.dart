import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/routing/arguments_models.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/widgets/poster_card/components/bottom_lef_sub_card.dart';
import 'package:movura/core/widgets/poster_card/components/poster_background_image.dart';
import 'package:movura/core/widgets/poster_card/components/top_lef_sub_card.dart';
import 'package:movura/core/widgets/poster_card/components/top_right_sub_card.dart';

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
          RouteNames.detailsScreen,
          arguments: DetailsArgumentModel(
            mediaType: mediaModel?.mediaType ?? mediaType ?? "movie",
            mediaId: mediaModel!.id,
          ),
        );
      },
      child: Card(
        elevation: elevation ?? 11,
        shadowColor: shadowColor ?? AppColors.coolGray.withValues(alpha: 0.5),
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        child: SizedBox(
          width: width ?? 220.w,
          height: height ?? 310.h,
          child: Stack(
            fit: StackFit.expand,
            children: [
              PosterBackgroundImage(
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
