import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/widgets/poster_card/poster_card.dart';

import '../models/poster_model.dart';
import '../theming/text_styles.dart';

class CustomPostersGridView extends StatelessWidget {
  const CustomPostersGridView({super.key, required this.poster});

  final List<PosterModel> poster;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: poster.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: .57,
          mainAxisSpacing: 15.h,
          crossAxisSpacing: 14.w,
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return PosterCard(
            border: 10,
            subCardBorder: 10,
            mediaModel: poster[index],
            elevation: 5,
            maxLines: 2,
            titleStyle: TextStyles.font11BoldIceBlueMontserrat.copyWith(
              fontSize: 10.sp,
            ),
            subTextStyle: TextStyles.font11BoldIceBlueMontserrat.copyWith(
              fontSize: 10.sp,
            ),
          );
        },
      ),
    );
  }
}
