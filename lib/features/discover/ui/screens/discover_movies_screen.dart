import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/widgets/app_error_widget.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';
import 'package:movura/features/home/data/models/category_card_model.dart';
import 'package:movura/features/see_all/data/models/see_all_arguments.dart';

import '../../data/repo/discover_repo.dart';
import '../../logic/discover_movies_cubit.dart';
import '../widgets/discover_screen_template.dart';

class DiscoverMoviesScreen extends StatelessWidget {
  const DiscoverMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DiscoverMoviesCubit>()..getDiscoverMovies(),
      child: Scaffold(
        backgroundColor: AppColors.richEerieBlack,
        body: BlocBuilder<DiscoverMoviesCubit, DiscoverMoviesState>(
          builder: (context, state) {
            if (state is DiscoverMoviesLoading) {
              return const Center(child: MovuraLoadingIndicator());
            } else if (state is DiscoverMoviesLoaded) {
              return _buildContent(context, state);
            } else if (state is DiscoverMoviesError) {
              return AppErrorWidget(
                errorMessage: state.message,
                onRetry: () =>
                    context.read<DiscoverMoviesCubit>().getDiscoverMovies(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, DiscoverMoviesLoaded state) {
    final discoverRepo = sl<DiscoverRepo>();

    final sections = [
      DiscoverSectionData(
        title: 'Trending Today',
        items: state.trendingToday,
        onSeeAll: () => _navigateToSeeAll(
          context,
          "Trending Today",
          (page) => discoverRepo.getTrendingMovies("day", page: page),
        ),
      ),
      DiscoverSectionData(
        title: 'Trending This Week',
        items: state.trendingWeek,
        onSeeAll: () => _navigateToSeeAll(
          context,
          "Trending This Week",
          (page) => discoverRepo.getTrendingMovies("week", page: page),
        ),
      ),
      DiscoverSectionData(
        title: 'Now Playing',
        items: state.nowPlaying,
        onSeeAll: () => _navigateToSeeAll(
          context,
          "Now Playing",
          (page) => discoverRepo.getMoviesByCategory("now_playing", page: page),
        ),
      ),
      DiscoverSectionData(
        title: 'Upcoming Movies',
        items: state.upcoming,
        onSeeAll: () => _navigateToSeeAll(
          context,
          "Upcoming Movies",
          (page) => discoverRepo.getMoviesByCategory("upcoming", page: page),
        ),
      ),
    ];

    final List<CategoryCardModel> categories = [
      CategoryCardModel(
        color: AppColors.amberGold,
        title: 'Popular Movies',
        hint: "MOST VIEWED",
        icon: Icons.star_rounded,
        onTap: () => _navigateToSeeAll(
          context,
          "Popular Movies",
          (page) => discoverRepo.getMoviesByCategory("popular", page: page),
        ),
      ),
      CategoryCardModel(
        color: AppColors.deepCrimson,
        title: 'Top Rated Movies',
        hint: "CRITICS CHOICE",
        icon: Icons.military_tech_rounded,
        onTap: () => _navigateToSeeAll(
          context,
          "Top Rated Movies",
          (page) => discoverRepo.getMoviesByCategory("top_rated", page: page),
        ),
      ),
      CategoryCardModel(
        color: AppColors.coolGray,
        title: 'Discover by Genres',
        hint: "CATEGORIES",
        icon: Icons.grid_view_rounded,
        onTap: () => context.pushNamed(
          RouteNames.discoverByGenreScreen,
          arguments: {'isMovie': true},
        ),
      ),
    ];

    return DiscoverScreenTemplate(
      title: "Movies",
      featuredPosters: state.popular,
      horizontalSections: sections,
      categories: categories,
    );
  }

  void _navigateToSeeAll(
    BuildContext context,
    String title,
    Future<List<PosterModel>> Function(int page) fetchData,
  ) {
    context.pushNamed(
      RouteNames.seeAllScreen,
      arguments: SeeAllArguments(title: title, fetchData: fetchData),
    );
  }
}
