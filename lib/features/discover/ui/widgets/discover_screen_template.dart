import 'package:flutter/material.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/buttons/app_icon_button.dart';
import 'package:movura/features/home/data/models/category_card_model.dart';
import 'discover_category_list.dart';

class DiscoverScreenTemplate extends StatelessWidget {
  final String title;
  final List<CategoryCardModel> categories;

  const DiscoverScreenTemplate({
    super.key,
    required this.title,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
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
          title,
          style: TextStyles.font20SemiBoldNeonBlueManrope,
        ),
      ),
      body: DiscoverCategoryList(categories: categories),
    );
  }
}
