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
      child: ListView.separated(
        padding: AppSpacing.symmetric(vertical: 20),
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (_, _) => AppSpacing.verticalSpacing(AppSpacing.l),
        itemBuilder: (context, index) {
          return SizedBox(
            height: 120.h,
            child: CategoryCard(
              model: categories[index],
              onTap: categories[index].onTap,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }
}
