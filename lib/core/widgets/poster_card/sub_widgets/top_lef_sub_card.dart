import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/theming/text_styles.dart';

class TopLeftSubCard extends StatelessWidget {
  const TopLeftSubCard({
    super.key,
    required this.showMediaType,
    required this.subCardElevation,
    required this.subCardBorder,
    required this.subCardColor,
    required this.mediaModel,
    required this.mediaType,
    required this.subTextStyle,
  });

  final bool? showMediaType;
  final double? subCardElevation;
  final double? subCardBorder;
  final Color? subCardColor;
  final PosterModel? mediaModel;
  final String? mediaType;
  final TextStyle? subTextStyle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.topLeft,
      child: Padding(
        padding: EdgeInsets.all(2.0.r),
        child: showMediaType == true
            ? Card(
                elevation: subCardElevation ?? 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(subCardBorder ?? 10),
                ),
                color: subCardColor ?? Color(0xFF2C2938).withValues(alpha: .8),
                child: Padding(
                  padding: EdgeInsets.all(5.0.r),
                  child: Text(
                    mediaModel?.mediaType ?? mediaType ?? "N/A",
                    style: subTextStyle ?? TextStyles.font16SimiBoldPlatinumGray,
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
