import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/text_styles.dart';

import '../core/theming/colors.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: AppColors.neonBlue),
            pinned: false,
            title: Text(
              "Trending today",
              style: AppTextStyles.font20SimiBoldNeonBlueManrope.copyWith(
                  fontSize: 18.sp),),
            centerTitle: true,
            backgroundColor: Colors.transparent,

          )


        ],
      ),
    );
  }
}
