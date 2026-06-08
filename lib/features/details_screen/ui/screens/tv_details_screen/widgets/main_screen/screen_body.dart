import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/details_screen/data/models/tv_models/about_tv_series_model.dart';
import 'package:movura/features/details_screen/data/repos/tv_repos/tv_similar_repo.dart';
import 'package:movura/features/details_screen/logic/tv_series_cubit/reviews/reviews_cubit.dart';
import 'package:movura/features/details_screen/logic/tv_series_cubit/similar_content/similar_content_cubit.dart';
import 'package:movura/features/details_screen/ui/screens/tv_details_screen/widgets/about_tv_tab/about_tv_tab_body.dart';
import 'package:movura/features/details_screen/ui/screens/tv_details_screen/widgets/main_screen/tv_additional_data.dart';
import 'package:movura/features/details_screen/ui/screens/tv_details_screen/widgets/main_screen/tv_main_details.dart';
import 'package:movura/features/details_screen/ui/screens/tv_details_screen/widgets/main_screen/tv_story_and_genres.dart';

import '../../../../../../../core/networking/di.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/styles.dart';
import '../../../../../../../core/utils/helpers/spacing.dart';
import '../../../../../data/repos/tv_repos/tv_reviews_repo.dart';
import '../../../shared/widgets/buttons_row.dart';
import '../../reviews_tab_body.dart';
import '../../similar_tab_body.dart';

class TvScreenBody extends StatelessWidget {
  const TvScreenBody({super.key, required this.model});

  final AboutTvSeriesModel model;

  @override
  Widget build(BuildContext context) {
    String? trailerKey;
    final videos = model.tvVideos?.videoList;

    if (videos != null && videos.isNotEmpty) {
      final trailer = videos.firstWhere(
        (v) => v.type.toLowerCase() == 'trailer',
        orElse: () => videos.first,
      );
      trailerKey = trailer.key;
      if (kDebugMode) {
        print("this is the trailer kay: $trailerKey");
      }
    } else {
      if (kDebugMode) {
        print("trailer not exist");
      }
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesReviewsCubit>(
          create: (context) =>
          TvSeriesReviewsCubit(repo: sl<TvReviewsRepo>())
            ..getTvSeriesReviews(id: model.id),
        ),

        BlocProvider<TvSeriesSimilarContentCubit>(
          create: (context) =>
          TvSeriesSimilarContentCubit(repo: sl<TvSimilarRepo>())
            ..getSimilarTvSeries(id: model.id),
        ),
      ],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          TvMainDetails(model: model),
          ButtonsRow(videoKey: trailerKey),
          verticalSpacing(20),
          TvAdditionalData(model: model),
          TvStoryAndGenres(model: model),
          verticalSpacing(10),
          DefaultTabController(
            length: 3,
            child: Builder(
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
                      curve: Curves.easeInCirc,
                    );
                  }
                });

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      unselectedLabelStyle: Styles.font10MediumCoolGraySora
                          .copyWith(
                          fontWeight: FontWeight.bold, fontSize: 13.sp),
                      labelStyle: Styles.font13BoldNeonCyanSora,
                      indicatorColor: AppColors.neonCyan,
                      indicatorWeight: 3.0,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: AppColors.neonCyan,
                      unselectedLabelColor: AppColors.slateGray,
                      tabs: const [
                        Tab(text: "ABOUT"),
                        Tab(text: "REVIEWS"),
                        Tab(text: "SIMILAR"),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    ExpandablePageView(
                      controller: pageController,
                      onPageChanged: (index) {
                        tabController.animateTo(index);
                      },
                      children: [
                        AboutTvTabBody(),
                        ReviewsTabBody(),
                        SimilarTabBody(),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
