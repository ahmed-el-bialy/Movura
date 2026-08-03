import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/poster_card/poster_card.dart';

class MediaHorizontalList extends StatelessWidget {
  const MediaHorizontalList({
    super.key,
    required this.items,
    this.mediaType,
    this.height = 260,
    this.cardWidth = 170,
    this.showMediaType = false,
    this.titleSize,
  });

  final List<PosterModel> items;
  final String? mediaType;
  final double height;
  final double cardWidth;
  final bool showMediaType;
  final double? titleSize;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: height.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: AppSpacing.symmetric(horizontal: 10, vertical: 12),
            child: PosterCard(
              width: cardWidth.w,
              elevation: 8,
              border: 15,
              titleStyle: TextStyles.font14BoldIceBlueMontserrat.copyWith(
                fontSize: titleSize?.sp ?? 13.sp,
              ),
              mediaModel: items[index],
              mediaType: mediaType ?? items[index].mediaType,
              showMediaType: showMediaType,
            ),
          );
        },
      ),
    );
  }
}
