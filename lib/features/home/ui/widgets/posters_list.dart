import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/poster_model.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/poster_card/poster_card.dart';

class PostersList extends StatelessWidget {
  const PostersList(
      {super.key, required this.mediaType, required this.posters});

  final String mediaType;
  final List<PosterModel> posters;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260.h,

      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: posters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.h),
            child: PosterCard(
              width: 170,
              elevation: 10,
              border: 15,
              titleStyle: TextStyles.font14BoldIceBlueMontserrat,
              subCardElevation: 3,
              subTextStyle: TextStyles.font11BoldGold.copyWith(fontSize: 12.sp),
              mediaModel: posters[index],
              mediaType: mediaType,
              showMediaType: false,
            ),
          );
        },
      ),
    );
  }
}
