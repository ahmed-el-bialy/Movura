import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/widgets/section_title.dart';
import 'package:movura/features/home/ui/widgets/category_list.dart';
import 'package:movura/features/home/ui/widgets/custom_side_drawer.dart';
import 'package:movura/features/home/ui/widgets/home_app_bar.dart';
import 'package:movura/features/home/ui/widgets/top_movies_list.dart';
import 'package:movura/features/home/ui/widgets/top_tv_series_list.dart';
import 'package:movura/features/home/ui/widgets/trending_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomSideDrawer(),
      backgroundColor: AppColors.richEerieBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const HomeAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 15.h, bottom: 20.h),
                child: const CategoryList(),
              ),
            ),
            SliverToBoxAdapter(
              child: SectionTitle(
                sectionName: "Trending Now",
                actionName: "See All ",
                onTap: () => context.pushNamed(RouteNames.trendingScreen),
              ),
            ),
            const TrendingList(),
            sliverVerticalSpacing(25),
            const SliverToBoxAdapter(
              child: SectionTitle(
                sectionName: "Top Rated Movies",
                actionName: "See All ",
              ),
            ),
            const SliverToBoxAdapter(child: TopMoviesList()),
            sliverVerticalSpacing(25),
            const SliverToBoxAdapter(
              child: SectionTitle(
                sectionName: "Top Rated TV Series",
                actionName: "See All ",
              ),
            ),
            const SliverToBoxAdapter(child: TopTvSeriesList()),
            sliverVerticalSpacing(100),
          ],
        ),
      ),
    );
  }
}
