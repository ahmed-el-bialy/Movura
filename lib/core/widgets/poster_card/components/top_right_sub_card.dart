import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/poster_model.dart';
import '../../../theming/app_colors.dart';
import '../../../theming/app_spacing.dart';
import '../../../theming/text_styles.dart';
import 'glass_card.dart';

class TopRightSubCard extends StatelessWidget {
  const TopRightSubCard({
    super.key,
    required this.showRating,
    required this.subCardBorder,
    required this.subCardColor,
    required this.subCardElevation,
    required this.mediaModel,
    required this.subTextStyle,
  });

  final bool? showRating;
  final double? subCardBorder;
  final Color? subCardColor;
  final double? subCardElevation;
  final PosterModel? mediaModel;
  final TextStyle? subTextStyle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: showRating == true
          ? Padding(
              padding: AppSpacing.all(2),
              child: GlassCard(
                borderRadius: subCardBorder ?? 10,
                color: subCardColor,
                padding: AppSpacing.all(5),
                child: mediaModel?.mediaType != "person"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            mediaModel?.voteAverage != null &&
                                    mediaModel!.voteAverage! > 0
                                ? "${mediaModel!.voteAverage!.toStringAsFixed(1)} "
                                : "N/A ",
                            style:
                                subTextStyle ??
                                TextStyles.font16SemiBoldPlatinumGray.copyWith(
                                  fontSize: 14.sp,
                                ),
                          ),
                          Icon(
                            Icons.star_rounded,
                            size: subTextStyle?.fontSize ?? 16.sp,
                            color: AppColors.amberGold,
                          ),
                        ],
                      )
                    : Text(
                        mediaModel?.knownForDepartment ?? "Unknown",
                        style:
                            subTextStyle ??
                            TextStyles.font16SemiBoldPlatinumGray.copyWith(
                              fontSize: 14.sp,
                            ),
                      ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
