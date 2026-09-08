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
import '../../logic/discover_tv_cubit.dart';
import '../widgets/discover_screen_template.dart';

class DiscoverTvScreen extends StatelessWidget {
  const DiscoverTvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DiscoverTvCubit>()..getDiscoverTv(),
      child: Scaffold(
        backgroundColor: AppColors.richEerieBlack,
        body: BlocBuilder<DiscoverTvCubit, DiscoverTvState>(
          builder: (context, state) {
            if (state is DiscoverTvLoading) {
              return const Center(child: MovuraLoadingIndicator());
            } else if (state is DiscoverTvLoaded) {
              return _buildContent(context, state);
            } else if (state is DiscoverTvError) {
              return AppErrorWidget(
                errorMessage: state.message,
                onRetry: () => context.read<DiscoverTvCubit>().getDiscoverTv(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, DiscoverTvLoaded state) {
    final discoverRepo = sl<DiscoverRepo>();

    final sections = [
      DiscoverSectionData(
        title: 'Trending Today',
        items: state.trendingToday,
        onSeeAll: () => _navigateToSeeAll(
          context,
          "Trending Today",
          (page) => discoverRepo.getTrendingTv("day", page: page),
        ),
      ),
      DiscoverSectionData(
        title: 'Trending This Week',
        items: state.trendingWeek,
        onSeeAll: () => _navigateToSeeAll(
          context,
          "Trending This Week",
          (page) => discoverRepo.getTrendingTv("week", page: page),
        ),
      ),
      DiscoverSectionData(
        title: 'On The Air',
        items: state.onTheAir,
        onSeeAll: () => _navigateToSeeAll(
          context,
          "On The Air",
          (page) => discoverRepo.getTvByCategory("on_the_air", page: page),
        ),
      ),
    ];

    final List<CategoryCardModel> categories = [
      CategoryCardModel(
        color: AppColors.amberGold,
        title: 'Popular TV Shows',
        hint: "MOST WATCHED",
        icon: Icons.star_rounded,
        onTap: () => _navigateToSeeAll(
          context,
          "Popular TV Shows",
          (page) => discoverRepo.getTvByCategory("popular", page: page),
        ),
      ),
      CategoryCardModel(
        color: AppColors.deepCrimson,
        title: 'Top Rated TV Shows',
        hint: "CRITICS CHOICE",
        icon: Icons.military_tech_rounded,
        onTap: () => _navigateToSeeAll(
          context,
          "Top Rated TV Shows",
          (page) => discoverRepo.getTvByCategory("top_rated", page: page),
        ),
      ),
      CategoryCardModel(
        color: AppColors.coolGray,
        title: 'Discover by Genres',
        hint: "CATEGORIES",
        icon: Icons.grid_view_rounded,
        onTap: () => context.pushNamed(
          RouteNames.discoverByGenreScreen,
          arguments: {'isMovie': false},
        ),
      ),
    ];

    return DiscoverScreenTemplate(
      title: "TV Series",
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
