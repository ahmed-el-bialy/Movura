import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/widgets/section_title.dart';
import 'package:movura/features/home/ui/widgets/category_list.dart';
import 'package:movura/features/home/ui/widgets/custom_side_drawer.dart';
import 'package:movura/features/home/ui/widgets/home_app_bar.dart';
import 'package:movura/features/home/ui/widgets/sub_widgets/home_trending_banner.dart';
import 'package:movura/features/home/ui/widgets/top_movies_list.dart';
import 'package:movura/features/home/ui/widgets/top_tv_series_list.dart';
import 'package:movura/features/home/ui/widgets/trending_list.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/routing/route_names.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomSideDrawer(),
      backgroundColor: AppColors.richEerieBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          slivers: [
            HomeAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
                child: CategoryList(),
              ),
            ),
            const SliverToBoxAdapter(
              child: HomeTrendingBanner(),
            ),
            SliverToBoxAdapter(
              child: SectionTitle(
                sectionName: "Trending Now",
                actionName: "See All ",
                onTap: () {
                  context.pushNamed(RouteNames.trendingScreen, null);
                },
              ),
            ),
            TrendingList(),
            sliverVerticalSpacing(25),
            SliverToBoxAdapter(
              child: SectionTitle(
                sectionName: "Top Rated Movies",
                actionName: "See All ",
              ),
            ),
            SliverToBoxAdapter(child: TopMoviesList()),
            sliverVerticalSpacing(25),
            SliverToBoxAdapter(
              child: SectionTitle(
                sectionName: "Top Rated TV Series",
                actionName: "See All ",
              ),
            ),
            SliverToBoxAdapter(child: TopTvSeriesList()),
            sliverVerticalSpacing(100),
          ],
        ),
      ),
    );
  }
}
