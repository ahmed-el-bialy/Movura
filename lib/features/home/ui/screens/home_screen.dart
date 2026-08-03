import 'package:flutter/material.dart';

import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/widgets/layout/section_title.dart';
import '../../../see_all/data/models/see_all_arguments.dart';
import '../widgets/category_list.dart';
import '../widgets/custom_side_drawer.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/top_movies_list.dart';
import '../widgets/top_tv_series_list.dart';
import '../widgets/trending_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomSideDrawer(),
      backgroundColor: AppColors.richEerieBlack,
      body: Padding(
        padding: AppSpacing.horizontal(6),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const HomeAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: AppSpacing.only(top: 15, bottom: 20),
                child: const CategoryList(),
              ),
            ),
            SliverToBoxAdapter(
              child: SectionTitle(
                sectionName: "Trending Now",
                actionName: "See All ",
                onTap: () => context.pushNamed(
                  RouteNames.seeAllScreen,
                  arguments: SeeAllArguments(
                    title: "Trending Now",
                    endpoint: SeeAllEndpoint.trendingMoviesDay,
                  ),
                ),
              ),
            ),
            const TrendingList(),
            AppSpacing.sliverVerticalSpacing(25),
            SliverToBoxAdapter(
              child: SectionTitle(
                sectionName: "Top Rated Movies",
                actionName: "See All ",
                onTap: () => context.pushNamed(
                  RouteNames.seeAllScreen,
                  arguments: SeeAllArguments(
                    title: "Top Rated Movies",
                    endpoint: SeeAllEndpoint.topRatedMovies,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: TopMoviesList()),
            AppSpacing.sliverVerticalSpacing(25),
            SliverToBoxAdapter(
              child: SectionTitle(
                sectionName: "Top Rated TV Series",
                actionName: "See All ",
                onTap: () => context.pushNamed(
                  RouteNames.seeAllScreen,
                  arguments: SeeAllArguments(
                    title: "Top Rated TV Series",
                    endpoint: SeeAllEndpoint.topRatedTv,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: TopTvSeriesList()),
            AppSpacing.sliverVerticalSpacing(100),
          ],
        ),
      ),
    );
  }
}
