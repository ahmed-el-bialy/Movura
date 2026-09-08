import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/buttons/app_icon_button.dart';
import 'package:movura/core/widgets/layout/media_horizontal_list.dart';
import 'package:movura/core/widgets/layout/section_title.dart';
import 'package:movura/features/home/data/models/category_card_model.dart';
import 'package:movura/features/home/ui/widgets/category_card.dart';
import 'package:movura/features/home/ui/widgets/hero_carousel.dart';

class DiscoverScreenTemplate extends StatelessWidget {
  final String title;
  final List<PosterModel>? featuredPosters;
  final List<DiscoverSectionData> horizontalSections;
  final List<CategoryCardModel> categories;

  const DiscoverScreenTemplate({
    super.key,
    required this.title,
    this.featuredPosters,
    this.horizontalSections = const [],
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.richEerieBlack,
            elevation: 0,
            pinned: true,
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

          // Featured Carousel
          if (featuredPosters != null && featuredPosters!.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: AppSpacing.only(top: 15, bottom: 20),
                child: HeroCarousel(posters: featuredPosters!),
              ),
            ),

          // Horizontal Sections
          ...horizontalSections.map((section) => SliverToBoxAdapter(
            child: Column(
              children: [
                SectionTitle(
                  sectionName: section.title,
                  actionName: 'See All ',
                  onTap: section.onSeeAll,
                ),
                MediaHorizontalList(
                  items: section.items,
                  showMediaType: true,
                  height: 330,
                  cardWidth: 220,
                ),
                AppSpacing.verticalSpacing(25),
              ],
            ),
          )),

          // Categories Title
          if (categories.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: AppSpacing.horizontal16().copyWith(top: 10, bottom: 15),
                child: Text(
                  "EXPLORE CATEGORIES",
                  style: TextStyles.font10BoldCoolGray.copyWith(
                    letterSpacing: 2,
                    color: AppColors.neonBlue.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ),

          // Categories Grid
          SliverPadding(
            padding: AppSpacing.horizontal16(),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 15.h,
                childAspectRatio: 1.1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => CategoryCard(
                  model: categories[index],
                  onTap: categories[index].onTap,
                ),
                childCount: categories.length,
              ),
            ),
          ),
          
          AppSpacing.sliverVerticalSpacing(50),
        ],
      ),
    );
  }
}

class DiscoverSectionData {
  final String title;
  final List<PosterModel> items;
  final VoidCallback onSeeAll;

  DiscoverSectionData({
    required this.title,
    required this.items,
    required this.onSeeAll,
  });
}
