import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/core/theming/app_spacing.dart';
import '../../../home/data/models/category_card_model.dart';
import '../../../home/ui/widgets/category_card.dart';

class DiscoverCategoryList extends StatelessWidget {
  const DiscoverCategoryList({super.key, required this.categories});

  final List<CategoryCardModel> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.horizontal16(),
      child: GridView.builder(
        padding: AppSpacing.symmetric(vertical: 20),
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.w,
          mainAxisSpacing: 15.h,
          childAspectRatio: 1.1,
        ),
        itemCount: categories.length,
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
