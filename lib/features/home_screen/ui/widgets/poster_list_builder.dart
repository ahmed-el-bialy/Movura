import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/widgets/poster_card.dart';

class PosterListBuilder extends StatelessWidget {
  const PosterListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 12.h),
            child: PosterCard(),
          );
        },
      ),
    );
  }
}
