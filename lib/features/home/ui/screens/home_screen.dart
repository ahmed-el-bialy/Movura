import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/widgets/layout/section_title.dart';

import '../../../see_all/data/models/see_all_arguments.dart';
import '../../data/repo/home_repo.dart';
import '../../logic/spotlight/spotlight_cubit.dart';
import '../../logic/top_rated_movies/top_rated_movies_cubit.dart';
import '../../logic/top_rated_tv_series/top_rated_tv_series_cubit.dart';
import '../../logic/trending_content/trending_content_cubit.dart';
import '../widgets/custom_side_drawer.dart';
import '../widgets/hero_carousel.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/top_movies_list.dart';
import '../widgets/top_tv_series_list.dart';
import '../widgets/trending_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeRepo = sl<HomeRepo>();

    return Scaffold(
      drawer: const CustomSideDrawer(),
      backgroundColor: AppColors.richEerieBlack,
      body: Padding(
        padding: AppSpacing.horizontal(6),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const HomeAppBar(),

            // ── Hero Spotlight (weekly trending) ──────────────────────────
            SliverToBoxAdapter(
              child: BlocBuilder<SpotlightCubit, SpotlightState>(
                builder: (context, state) {
                  if (state is SpotlightLoaded && state.posters.isNotEmpty) {
                    return Padding(
                      padding: AppSpacing.only(top: 10, bottom: 10),
                      child: HeroCarousel(posters: state.posters),
                    );
                  }
                  if (state is SpotlightError) {
                    return const SizedBox.shrink();
                  }
                  return const HeroCarouselSkeleton();
                },
              ),
            ),
            AppSpacing.sliverVerticalSpacing(15),
            // ── Trending Now (daily) ──────────────────────────────────────
            SliverToBoxAdapter(
              child: Builder(
                builder: (context) {
                  return SectionTitle(
                    sectionName: 'Trending Now',
                    actionName: 'See All ',
                    onTap: () {
                      final state = context.read<TrendingContentCubit>().state;
                      final initial =
                          state is TrendingContentLoaded ? state.posters : null;
                      context.pushNamed(
                        RouteNames.seeAllScreen,
                        arguments: SeeAllArguments(
                          title: 'Trending Now',
                          initialItems: initial,
                          fetchData: (page) =>
                              homeRepo.getTrendingMedia(page: page),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const TrendingList(),
            AppSpacing.sliverVerticalSpacing(25),

            // ── Top Rated Movies ─────────────────────────────────────────
            SliverToBoxAdapter(
              child: Builder(
                builder: (context) {
                  return SectionTitle(
                    sectionName: 'Top Rated Movies',
                    actionName: 'See All ',
                    onTap: () {
                      final state = context.read<TopRatedMovieCubit>().state;
                      final initial =
                          state is TopRatedMovieLoaded ? state.posters : null;
                      context.pushNamed(
                        RouteNames.seeAllScreen,
                        arguments: SeeAllArguments(
                          title: 'Top Rated Movies',
                          initialItems: initial,
                          fetchData: (page) =>
                              homeRepo.getTopRatedMovies(page: page),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(child: TopMoviesList()),
            AppSpacing.sliverVerticalSpacing(25),

            // ── Top Rated TV Series ──────────────────────────────────────
            SliverToBoxAdapter(
              child: Builder(
                builder: (context) {
                  return SectionTitle(
                    sectionName: 'Top Rated TV Series',
                    actionName: 'See All ',
                    onTap: () {
                      final state = context.read<TopRatedTvSeriesCubit>().state;
                      final initial = state is TopRatedTvSeriesLoaded
                          ? state.posters
                          : null;
                      context.pushNamed(
                        RouteNames.seeAllScreen,
                        arguments: SeeAllArguments(
                          title: 'Top Rated TV Series',
                          initialItems: initial,
                          fetchData: (page) =>
                              homeRepo.getTopRatedTvSeries(page: page),
                        ),
                      );
                    },
                  );
                },
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
