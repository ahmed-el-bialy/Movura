import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/widgets/poster_card.dart';

import '../../data/model/poster_model.dart';

class PosterListBuilder extends StatelessWidget {
  const PosterListBuilder({super.key, required this.trendingContent});

  final List<PosterModel> trendingContent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: trendingContent.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 12.h),
            child: PosterCard(media: trendingContent[index]),
          );
        },
      ),
    );
  }
}
