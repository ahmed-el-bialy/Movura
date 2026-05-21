import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/details_screen/data/models/about_model.dart';

import '../../../../../core/helper/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../sub_screen/about_tab_section.dart';
import 'action_buttons_part.dart';
import 'first_lock_part.dart';
import 'story_line.dart';

class SuccessBuildBody extends StatelessWidget {
  const SuccessBuildBody({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        FirstLockPart(model: model),

        ActionButtonsPart(),

        verticalSpacing(20),
        StoryLine(model: model),
        verticalSpacing(10),

        DefaultTabController(
          length: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                unselectedLabelStyle: Styles.font10CoolGrayMediumSora.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
                labelStyle: Styles.font13NeonCyanBoldSora,
                indicatorColor: AppColors.neonCyan,
                indicatorWeight: 3.0,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: AppColors.neonCyan,
                unselectedLabelColor: AppColors.slateGray,
                tabs: [
                  Tab(text: "ABOUT"),
                  Tab(text: "REVIEWS"),
                  Tab(text: "SIMILAR"),
                ],
              ),

              SizedBox(height: 10.h),
              // مسافة خفيفة بين الـ Tabs والمحتوى

              // 2. محتوى الـ Tabs (الـ TabBarView)
              // استخدمنا SizedBox هنا وحددنا ارتفاع ثابت لأنها جزء من شاشة مش الشاشة كلها
              SizedBox(
                height: 800.h,
                // حدد الارتفاع المناسب لمحتويات الـ Tabs بالصور بتاعتها
                child: TabBarView(
                  children: [
                    // الـ Tab الأول: Media (جواه العنوان والـ ListView الأفقية)
                    AboutTabContent(),

                    // الـ Tab الثاني
                    const Center(
                      child: Text(
                        "Cast Content",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    // الـ Tab الثالث
                    const Center(
                      child: Text(
                        "Similar Content",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
