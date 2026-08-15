import 'package:flutter/material.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/features/home/data/models/category_card_model.dart';
import 'package:movura/features/see_all/data/models/see_all_arguments.dart';
import '../widgets/discover_screen_template.dart';

import '../../data/repo/discover_repo.dart';

class DiscoverTvScreen extends StatelessWidget {
  const DiscoverTvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final discoverRepo = sl<DiscoverRepo>();

    final List<CategoryCardModel> categories = [
      CategoryCardModel(
        color: AppColors.vibrantPurple,
        title: 'Trending Today',
        hint: "DAILY UPDATES",
        icon: Icons.whatshot_rounded,
        onTap: () => _navigateToSeeAll(
          context,
          "Trending Today",
          (page) => discoverRepo.getTrendingTv("day", page: page),
        ),
      ),
      CategoryCardModel(
        color: AppColors.electricBlueAccent,
        title: 'Trending This Week',
        hint: "WEEKLY TOP",
        icon: Icons.local_fire_department_rounded,
        onTap: () => _navigateToSeeAll(
          context,
          "Trending This Week",
          (page) => discoverRepo.getTrendingTv("week", page: page),
        ),
      ),
      CategoryCardModel(
        color: AppColors.tealCyan,
        title: 'On The Air',
        hint: "CURRENTLY AIRING",
        icon: Icons.live_tv_rounded,
        onTap: () => _navigateToSeeAll(
          context,
          "On The Air",
          (page) => discoverRepo.getTvByCategory("on_the_air", page: page),
        ),
      ),
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
