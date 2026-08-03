import 'package:flutter/material.dart';

import '../../../../core/extensions/routing_extension.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../home/data/models/category_card_model.dart';
import '../widgets/discover_category_list.dart';
import '../../../see_all/data/models/see_all_arguments.dart';

class DiscoverPeopleScreen extends StatelessWidget {
  const DiscoverPeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryCardModel> categories = [
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
          "Popular People",
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
