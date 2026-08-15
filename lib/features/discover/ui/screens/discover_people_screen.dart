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

class DiscoverPeopleScreen extends StatelessWidget {
  const DiscoverPeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final discoverRepo = sl<DiscoverRepo>();

    final List<CategoryCardModel> categories = [
      CategoryCardModel(
        color: AppColors.neonBlue,
        title: 'Trending Today',
        hint: "DAILY UPDATES",
        icon: Icons.trending_up_rounded,
        onTap: () => _navigateToSeeAll(
          context,
          "Trending People",
          (page) => discoverRepo.getTrendingPeople("day", page: page),
        ),
      ),
      CategoryCardModel(
        color: AppColors.amberGold,
        title: 'Popular People',
        hint: "MOST VIEWED",
        icon: Icons.star_rounded,
        onTap: () => _navigateToSeeAll(
          context,
          "Popular People",
          (page) => discoverRepo.getPopularPeople(page: page),
        ),
      ),
    ];

    return DiscoverScreenTemplate(
      title: "Discover People",
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
