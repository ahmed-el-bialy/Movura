import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/features/search/logic/search/search_cubit.dart';
import 'package:movura/features/search/ui/custom_search_delegate.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/helpers/spacing.dart';
import '../../data/models/category_card_model.dart';
import 'category_card.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryCardModel> categories = [
      CategoryCardModel(
        color: Colors.deepPurple,
        title: 'Popular TV Series',
        hint: "TOP CHOICE",
        icon: Icons.tv_rounded,
        onTap: () {
          context.pushNamed(RouteNames.trendingScreen, null);
        },
      ),
      CategoryCardModel(
        color: Colors.blueAccent,
        title: 'Popular Movies',
        hint: "TOP CHOICE",
        icon: Icons.auto_awesome_rounded,
        onTap: () {
          context.pushNamed(RouteNames.trendingScreen, null);
        },
      ),
      CategoryCardModel(
        color: Colors.cyan,
        title: 'Trending Today',
        hint: "DAILY UPDATES",
        icon: Icons.trending_up_rounded,
        onTap: () {
          context.pushNamed(RouteNames.trendingScreen, null);
        },
      ),
      CategoryCardModel(
        color: Colors.indigoAccent,
        title: 'Celebrities',
        hint: "PEOPLE",
        icon: Icons.people_alt_rounded,
        onTap: () {
          showSearch(
            context: context,
            delegate: CustomSearchDelegate(searchCubit: sl<SearchCubit>()),
          );
        },
      ),
    ];

    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (context, index) => horizontalSpacing(12),
        itemBuilder: (context, index) {
          return CategoryCard(
            model: categories[index],
            onTap: categories[index].onTap,
          );
        },
      ),
    );
  }
}
