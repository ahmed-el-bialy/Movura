import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';

class BottomLeftSubCard extends StatelessWidget {
  const BottomLeftSubCard({
    super.key,
    required this.subCardBorder,
    required this.subCardElevation,
    required this.subCardColor,
    required this.mediaModel,
    required this.titleStyle,
    required this.maxLines,
  });

  final double? subCardBorder;
  final double? subCardElevation;
  final Color? subCardColor;
  final PosterModel? mediaModel;
  final TextStyle? titleStyle;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.all(2.0.r),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(subCardBorder ?? 10),
          ),
          elevation: subCardElevation ?? 8,
          color: subCardColor ?? AppColors.darkPurpleGray.withValues(alpha: .7),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.w),
            child: Text(
              mediaModel?.title ?? mediaModel?.name ?? "Unknown Title",
              style: titleStyle ?? TextStyles.font17BoldIceBlueMontserrat,
              overflow: TextOverflow.ellipsis,
              maxLines: maxLines ?? 1,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}
