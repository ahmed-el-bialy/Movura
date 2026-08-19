import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';
import 'package:movura/core/widgets/poster_card/poster_card.dart';
import 'package:movura/features/library/logic/library_cubit.dart';
import 'package:movura/features/library/logic/library_state.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<LibraryCubit>(),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: AppColors.richEerieBlack,
          appBar: AppBar(
            backgroundColor: AppColors.richEerieBlack,
            elevation: 0,
            title: Text(
              'My Library',
              style: TextStyles.font24SemiBoldNeonBlueManrope.copyWith(
                fontSize: 22.sp,
              ),
            ),
            bottom: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              unselectedLabelStyle: TextStyles.font10MediumCoolGraySora.copyWith(
                fontWeight: Weights.bold,
                fontSize: 13.sp,
              ),
              labelStyle: TextStyles.font13BoldNeonBlueSora,
              indicatorColor: AppColors.neonBlue,
              indicatorWeight: 3.0,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppColors.neonBlue,
              unselectedLabelColor: AppColors.slateGray,
              padding: AppSpacing.horizontal(5),
              tabs: const [
                Tab(text: "Watch Now"),
                Tab(text: "To Watch"),
                Tab(text: "Watched"),
                Tab(text: "Favorites"),
              ],
            ),
          ),
          body: SafeArea(
            child: BlocBuilder<LibraryCubit, LibraryState>(
              builder: (context, state) {
                if (state is LibraryLoading) {
                  return const Center(child: MovuraLoadingIndicator());
                }

                final userModel = state is LibraryLoaded ? state.userModel : null;

                return Builder(
                  builder: (context) {
                    final tabController = DefaultTabController.of(context);
                    final pageController = PageController(
                      initialPage: tabController.index,
                    );

                    tabController.addListener(() {
                      if (!tabController.indexIsChanging &&
                          pageController.hasClients) {
                        pageController.animateToPage(
                          tabController.index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    });

                    return ExpandablePageView(
                      controller: pageController,
                      onPageChanged: (index) {
                        tabController.animateTo(index);
                      },
                      children: [
                        _LibraryTabContent(
                          title: 'Watch It Now',
                          items: userModel?.watchNow ?? [],
                        ),
                        _LibraryTabContent(
                          title: 'To Watch',
                          items: userModel?.toWatch ?? [],
                        ),
                        _LibraryTabContent(
                          title: 'Watched',
                          items: userModel?.watched ?? [],
                        ),
                        _LibraryTabContent(
                          title: 'Favorites',
                          items: userModel?.favorites ?? [],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _LibraryTabContent extends StatelessWidget {
  const _LibraryTabContent({
    required this.title,
    required this.items,
  });

  final String title;
  final List<PosterModel> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: AppSpacing.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSpacing.verticalSpacing(40),
              Icon(
                Icons.movie_filter_rounded,
                size: 80.sp,
                color: AppColors.onyxBlack,
              ),
              AppSpacing.verticalSpacing(20),
              Text(
                'No items in $title',
                style: TextStyles.font17BoldIceBlueMontserrat.copyWith(
                  color: AppColors.slateGray,
                ),
              ),
              AppSpacing.verticalSpacing(10),
              Text(
                'Start adding your favorite movies and TV shows to see them here.',
                textAlign: TextAlign.center,
                style: TextStyles.font12RegularCoolGrayManrope,
              ),
              AppSpacing.verticalSpacing(100),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: AppSpacing.all(AppSpacing.l),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.55,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 12.h,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return PosterCard(
          mediaModel: item,
          mediaType: item.mediaType,
          elevation: 6,
          width: double.infinity,
          height: double.infinity,
          border: 12,
          titleStyle: TextStyles.font14BoldIceBlueMontserrat.copyWith(
            fontSize: 11.sp,
            fontWeight: Weights.extraBold,
          ),
          subTextStyle: TextStyles.font16SemiBoldPlatinumGray.copyWith(
            fontSize: 10.sp,
            letterSpacing: 0.5,
          ),
          showMediaType: true,
          maxLines: 2,
        );
      },
    );
  }
}
