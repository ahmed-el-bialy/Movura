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
    return DiscoverScreenTemplate(
      title: "Popular People",
      categories: _PeopleCategories.getCategories(context),
    );
  }
}

class _PeopleCategories {
  static List<CategoryCardModel> getCategories(BuildContext context) {
    return [
      CategoryCardModel(
        color: AppColors.vibrantPurple,
        title: 'Popular People',
        hint: "TOP CELEBRITIES",
        icon: Icons.people_alt_rounded,
        onTap: () => _navigateToSeeAll(
          context,
          "Popular People",
          SeeAllEndpoint.popularPeople,
        ),
      ),
      CategoryCardModel(
        color: AppColors.electricBlueAccent,
        title: 'Trending People',
        hint: "TRENDING TODAY",
        icon: Icons.trending_up_rounded,
        onTap: () => _navigateToSeeAll(
          context,
          "Trending People",
          SeeAllEndpoint.trendingPeople,
        ),
      ),
    ];
  }

  static void _navigateToSeeAll(
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
