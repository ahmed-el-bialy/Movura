import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

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
              padding: EdgeInsets.all(2.0.r),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(subCardBorder ?? 10),
                ),
                color: subCardColor ?? AppColors.darkPurpleGray.withValues(alpha: .7),
                elevation: subCardElevation ?? 10,
                child: Padding(
                  padding: EdgeInsets.all(5.0.r),
                  child: mediaModel?.mediaType != "person"
                      ? Row(
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
                                  TextStyles.font16SimiBoldPlatinumGray,
                            ),
                            Icon(
                              Icons.star_purple500_outlined,
                              size: subTextStyle?.fontSize ?? 18.sp,
                              color:
                                  subTextStyle?.color ??
                                  TextStyles.font16SimiBoldPlatinumGray.color,
                            ),
                          ],
                        )
                      : Text(
                          mediaModel?.knownForDepartment ?? "Unknown",
                          style:
                              subTextStyle ?? TextStyles.font16SimiBoldPlatinumGray,
                        ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
