import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/utils/helpers/spacing.dart';
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
    initialPage: 1,
  );

  final List<CategoryCardModel> categories = [
    CategoryCardModel(
      color: Colors.grey,
      title: 'Most Popular TV Series',
      hint: "TOP CHOICE",
      icon: Icons.tv_outlined,
      onTap: () {},
    ),

    CategoryCardModel(
      color: Colors.blueGrey,
      title: 'Most Popular Movies',
      hint: "TOP CHOICE",
      icon: Icons.local_fire_department_outlined,
      onTap: () {},
    ),

    CategoryCardModel(
      color: Colors.teal,
      title: 'Trending Movies',
      hint: "TODAY",
      icon: Icons.trending_up_outlined,
      onTap: () {},
    ),

    CategoryCardModel(
      color: Colors.indigo,
      title: 'Trending People',
      hint: "TODAY",
      icon: Icons.people_outline_rounded,
      onTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,

        height: 150.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: categories.length,
                controller: controller,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: CategoryCard(model: categories[index], onTap: () {}),
                  );
                },
              ),
            ),

            verticalSpacing(12),

            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: categories.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 6.h,
                  dotWidth: 6.w,
                  expansionFactor: 3,
                  activeDotColor: AppColors.neonBlue,
                  dotColor: AppColors.platinumGray.withValues(alpha: 0.4),
                  spacing: 6.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
