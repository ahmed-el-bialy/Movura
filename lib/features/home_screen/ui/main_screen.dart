
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/core/theming/styles.dart';

import '../../../core/helper/spacing.dart';
import '../../../core/widgets/poster_card.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          backgroundColor: AppColors.eerieBlack,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Image.asset(
                  "assets/images/mini_icon.png",
                  fit: BoxFit.fill,
                ),
              ),
              Text("MOVURA", style: Styles.font24NeonCyanSimiBoldManrope),
              Spacer(flex: 1),
              verticalSpacing(60.h),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search_outlined,
                  size: 26.sp,
                  color: AppColors.slateGray,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpacing(15.h),
            Text("Trending Now", style: Styles.font20platinumGraySimiBold),
            verticalSpacing(12.h),
            PosterCard(),
          ],
        ),)
      ,
    );
  }
}
