import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class DetailsTabs extends StatelessWidget {
  const DetailsTabs({super.key, required this.tabs, required this.children});

  final List<String> tabs;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context);
          final pageController = PageController(
            initialPage: tabController.index,
          );

          tabController.addListener(() {
            if (!tabController.indexIsChanging && pageController.hasClients) {
              pageController.animateToPage(
                tabController.index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInCirc,
              );
            }
          });

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                unselectedLabelStyle: TextStyles.font10MediumCoolGraySora
                    .copyWith(fontWeight: Weights.bold, fontSize: 13.sp),
                labelStyle: TextStyles.font13BoldNeonBlueSora,
                indicatorColor: AppColors.neonBlue,
                indicatorWeight: 3.0,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: AppColors.neonBlue,
                unselectedLabelColor: AppColors.slateGray,
                tabs: tabs.map((tab) => Tab(text: tab)).toList(),
              ),
              AppSpacing.verticalSpacing(10),
              ExpandablePageView(
                controller: pageController,
                onPageChanged: (index) {
                  tabController.animateTo(index);
                },
                children: children,
              ),
            ],
          );
        },
      ),
    );
  }
}
