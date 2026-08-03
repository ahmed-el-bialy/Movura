import 'package:flutter/material.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/features/home/data/models/category_card_model.dart';
import 'package:movura/features/see_all/data/models/see_all_arguments.dart';
import '../widgets/discover_screen_template.dart';

class DiscoverMoviesScreen extends StatelessWidget {
  const DiscoverMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryCardModel> categories = [
      CategoryCardModel(
        color: AppColors.vibrantPurple,
        title: 'Trending Today',
        hint: "DAILY UPDATES",
        icon: Icons.whatshot_rounded,
        onTap: () => _navigateToSeeAll(
          context,
          "Trending Today",
          SeeAllEndpoint.trendingMoviesDay,
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
          SeeAllEndpoint.trendingMoviesWeek,
        ),
      ),
      CategoryCardModel(
        color: AppColors.tealCyan,
        title: 'Upcoming Movies',
        hint: "COMING SOON",
        icon: Icons.upcoming_rounded,
        onTap: () => _navigateToSeeAll(
          context,
          "Upcoming Movies",
          SeeAllEndpoint.upcomingMovies,
        ),
      ),
      CategoryCardModel(
        color: AppColors.royalIndigo,
        title: 'Now Playing',
        hint: "IN THEATERS",
        icon: Icons.movie_creation_outlined,
        onTap: () => _navigateToSeeAll(
          context,
          "Now Playing",
          SeeAllEndpoint.nowPlayingMovies,
        ),
      ),
      CategoryCardModel(
        color: AppColors.amberGold,
        title: 'Popular Movies',
        hint: "MOST VIEWED",
        icon: Icons.star_rounded,
        onTap: () => _navigateToSeeAll(
          context,
          "Popular Movies",
          SeeAllEndpoint.popularMovies,
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
          SeeAllEndpoint.topRatedMovies,
        ),
      ),
    ];

    return DiscoverScreenTemplate(
      title: "Discover Movies",
      categories: categories,
    );
  }

  void _navigateToSeeAll(
    BuildContext context,
    String title,
    SeeAllEndpoint endpoint,
  ) {
    context.pushNamed(
      RouteNames.seeAllScreen,
      arguments: SeeAllArguments(title: title, endpoint: endpoint),
    );
  }
}
