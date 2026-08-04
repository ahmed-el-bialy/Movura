import 'package:flutter/material.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/features/home/data/models/category_card_model.dart';
import 'package:movura/features/see_all/data/models/see_all_arguments.dart';
import '../widgets/discover_screen_template.dart';

class DiscoverPeopleScreen extends StatelessWidget {
  const DiscoverPeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryCardModel> categories = [
      CategoryCardModel(
        color: AppColors.neonBlue,
        title: 'Trending Today',
        hint: "DAILY UPDATES",
        icon: Icons.trending_up_rounded,
        onTap: () => _navigateToSeeAll(
          context,
          "Trending People",
          SeeAllEndpoint.trendingPeople,
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
          SeeAllEndpoint.popularPeople,
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
    SeeAllEndpoint endpoint,
  ) {
    context.pushNamed(
      RouteNames.seeAllScreen,
      arguments: SeeAllArguments(title: title, endpoint: endpoint),
    );
  }
}
