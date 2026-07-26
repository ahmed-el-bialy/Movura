import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/features/search/logic/search/search_cubit.dart';
import 'package:movura/features/search/ui/screens/custom_search_delegate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/helpers/spacing.dart';
import '../../data/models/category_card_model.dart';
import 'category_card.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final PageController controller = PageController(
    viewportFraction: 0.85,
    initialPage: 0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<CategoryCardModel> categories = [
      CategoryCardModel(
        color: AppColors.vibrantPurple,
        title: 'Popular TV Series',
        hint: "TOP CHOICE",
        icon: Icons.tv_rounded,
        onTap: () {
          context.pushNamed(RouteNames.trendingScreen, arguments: null);
        },
      ),
      CategoryCardModel(
        color: AppColors.electricBlueAccent,
        title: 'Popular Movies',
        hint: "TOP CHOICE",
        icon: Icons.auto_awesome_rounded,
        onTap: () {
          context.pushNamed(RouteNames.trendingScreen, arguments: null);
        },
      ),
      CategoryCardModel(
        color: AppColors.tealCyan,
        title: 'Trending Today',
        hint: "DAILY UPDATES",
        icon: Icons.trending_up_rounded,
        onTap: () {
          context.pushNamed(RouteNames.trendingScreen, arguments: null);
        },
      ),
      CategoryCardModel(
        color: AppColors.royalIndigo,
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

    return Column(
      children: [
        SizedBox(
          height: 140.h,
          child: PageView.builder(
            itemCount: categories.length,
            controller: controller,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: CategoryCard(
                  model: categories[index],
                  onTap: categories[index].onTap,
                ),
              );
            },
          ),
        ),
        verticalSpacing(12),
        SmoothPageIndicator(
          controller: controller,
          count: categories.length,
          effect: ExpandingDotsEffect(
            dotHeight: 6.h,
            dotWidth: 6.w,
            expansionFactor: 3,
            activeDotColor: AppColors.neonBlue,
            dotColor: AppColors.platinumGray.withValues(alpha: 0.3),
            spacing: 6.w,
          ),
        ),
      ],
    );
  }
}
