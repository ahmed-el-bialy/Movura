import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/core/widgets/poster_card.dart';

class SubPosterListBuilder extends StatelessWidget {
  const SubPosterListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 12.h),
            child: PosterCard(
              height: 180,
              width: 150,
              elevation: 2,
              border: 7,
              titleStyle: Styles.font14IceBlueBoldMontserrat,
              subCardElevation: 3,
              subTextStyle: Styles.font11IGoldBold,
              
            ),
          );
        },
      ),
    );
  }
}
