import 'package:flutter/material.dart';

import '../../../../core/extensions/routing_extension.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../home/data/models/category_card_model.dart';
import '../widgets/discover_category_list.dart';
import '../../../see_all/data/models/see_all_arguments.dart';

class DiscoverTvScreen extends StatelessWidget {
  const DiscoverTvScreen({super.key});

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
          SeeAllEndpoint.trendingTvDay,
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
          SeeAllEndpoint.trendingTvWeek,
        ),
      ),
      CategoryCardModel(
        color: AppColors.tealCyan,
        title: 'On The Air',
        hint: "CURRENTLY AIRING",
        icon: Icons.live_tv_rounded,
        onTap: () =>
            _navigateToSeeAll(context, "On The Air", SeeAllEndpoint.onTheAirTv),
      ),
      CategoryCardModel(
        color: AppColors.amberGold,
        title: 'Popular TV Shows',
        hint: "MOST WATCHED",
        icon: Icons.star_rounded,
        onTap: () => _navigateToSeeAll(
          context,
          "Popular TV Shows",
          SeeAllEndpoint.popularTv,
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
          SeeAllEndpoint.topRatedTv,
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      appBar: AppBar(
        backgroundColor: AppColors.richEerieBlack,
        elevation: 0,
        centerTitle: true,
        leading: AppIconButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onPressed: () => context.pop(),
        ),
        title: Text(
          "TV Series",
          style: TextStyles.font20SimiBoldNeonBlueManrope,
        ),
      ),
      body: DiscoverCategoryList(categories: categories),
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
