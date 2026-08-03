import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.richEerieBlack,
        appBar: AppBar(
          backgroundColor: AppColors.richEerieBlack,
          elevation: 0,
          title: Text(
            'My Library',
            style: TextStyles.font24SemiBoldNeonBlueManrope.copyWith(
              fontSize: 22.sp,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            unselectedLabelStyle: TextStyles.font10MediumCoolGraySora.copyWith(
              fontWeight: Weights.bold,
              fontSize: 13.sp,
            ),
            labelStyle: TextStyles.font13BoldNeonBlueSora,
            indicatorColor: AppColors.neonBlue,
            indicatorWeight: 3.0,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppColors.neonBlue,
            unselectedLabelColor: AppColors.slateGray,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            tabs: const [
              Tab(text: "Watch Now"),
              Tab(text: "To Watch"),
              Tab(text: "Watched"),
              Tab(text: "Favorites"),
            ],
          ),
        ),
        body: SafeArea(
          child: Builder(
            builder: (context) {
              final tabController = DefaultTabController.of(context);
              final pageController = PageController(
                initialPage: tabController.index,
              );

              tabController.addListener(() {
                if (!tabController.indexIsChanging &&
                    pageController.hasClients) {
                  pageController.animateToPage(
                    tabController.index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              });

              return ExpandablePageView(
                controller: pageController,
                onPageChanged: (index) {
                  tabController.animateTo(index);
                },
                children: const [
                  _LibraryTabContent(title: 'Want to Watch'),
                  _LibraryTabContent(title: 'Watched'),
                  _LibraryTabContent(title: 'Later'),
                  _LibraryTabContent(title: 'Favorites'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _LibraryTabContent extends StatelessWidget {
  const _LibraryTabContent({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSpacing.verticalSpacing(40),
            Icon(
              Icons.movie_filter_rounded,
              size: 80.sp,
              color: AppColors.onyxBlack,
            ),
            AppSpacing.verticalSpacing(20),
            Text(
              'No items in $title',
              style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                color: AppColors.slateGray,
              ),
            ),
            AppSpacing.verticalSpacing(10),
            Text(
              'Start adding your favorite movies and TV shows to see them here.',
              textAlign: TextAlign.center,
              style: TextStyles.font12RegularCoolGrayManrope,
            ),
            AppSpacing.verticalSpacing(100),
          ],
        ),
      ),
    );
  }
}
