import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/poster_model.dart';
import '../../../../core/widgets/poster_card/poster_card.dart';

class TrendingPosterList extends StatelessWidget {
  const TrendingPosterList({
    super.key,
    required this.trendingContent,
    this.height,
  });

  final List<PosterModel> trendingContent;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height == null ? 330.h : height!.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: trendingContent.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
            child: PosterCard(mediaModel: trendingContent[index]),
          );
        },
      ),
    );
  }
}
