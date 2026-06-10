import 'package:flutter/material.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/features/home/ui/widgets/top_movies_list.dart';
import 'package:movura/features/home/ui/widgets/top_tv_series_list.dart';
import 'package:movura/features/home/ui/widgets/trending_list.dart';

import '../../../core/utils/helpers/spacing.dart';
import '../../../core/widgets/app_navigation_bar.dart';
import '../../../core/widgets/section_title.dart';
import 'widgets/custom_side_drawer.dart';
import 'widgets/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomSideDrawer(),
      extendBody: true,
      backgroundColor: AppColors.richEerieBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          slivers: [
            HomeAppBar(),

            SliverToBoxAdapter(child: verticalSpacing(15)),

            SliverToBoxAdapter(
              child: SectionTitle(
                sectionName: "Trending Now",
                actionName: "See All ",
              ),
            ),

            TrendingList(),

            SliverToBoxAdapter(child: verticalSpacing(25)),

            SliverToBoxAdapter(
              child: SectionTitle(
                sectionName: "Top Rated Movies",
                actionName: "See All ",
              ),
            ),

            SliverToBoxAdapter(child: TopMoviesList()),

            SliverToBoxAdapter(child: verticalSpacing(25)),

            SliverToBoxAdapter(
              child: SectionTitle(
                sectionName: "Top Rated TV Series",
                actionName: "See All ",
              ),
            ),

            SliverToBoxAdapter(child: TopTvSeriesList()),

            SliverToBoxAdapter(child: verticalSpacing(50)),
          ],
        ),
      ),

      bottomNavigationBar: AppNavigationBar(activeIndex: 0),
    );
  }
}
