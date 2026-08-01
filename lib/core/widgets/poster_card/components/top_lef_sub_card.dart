import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/poster_card/components/glass_card.dart';

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
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.all(2.0.r),
        child: showMediaType == true
            ? GlassCard(
                borderRadius: subCardBorder ?? 10,
                color: subCardColor,
                padding: EdgeInsets.all(5.0.r),
                child: Text(
                  (mediaModel?.mediaType ?? mediaType ?? "N/A").toUpperCase(),
                  style: subTextStyle ?? TextStyles.font16SimiBoldPlatinumGray.copyWith(fontSize: 13.sp, letterSpacing: 1.2),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
