import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/styles.dart';
import '../../../../../core/networking/di.dart';
import '../../../../../core/utils/helpers/spacing.dart';
import '../../../data/models/movie_models/about_model.dart';
import '../../../data/repos/movie_repos/reviews_repo.dart';
import '../../../data/repos/movie_repos/similar_repo.dart';
import '../../../logic/movie_screen_cubit/reviews/reviews_cubit.dart';
import '../../../logic/movie_screen_cubit/similar_content/similar_content_cubit.dart';
import '../about_tab/about_tab_body.dart';
import '../reviews_tab/reviews_tab_body.dart';
import '../similar_tab/similar_tab_body.dart';
import 'additional_data.dart';
import 'buttons_row.dart';
import 'movie_main_details.dart';
import 'movie_story_and_genres.dart';

class MovieScreenBody extends StatelessWidget {
  const MovieScreenBody({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    String? trailerKey;
    final videos = model.movieVideos?.videoList;

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
        BlocProvider<ReviewsCubit>(
          create: (context) =>
              ReviewsCubit(repo: sl<ReviewsRepo>())
                ..getMovieReviews(id: model.id),
        ),

        BlocProvider<SimilarContentCubit>(
          create: (context) =>
              SimilarContentCubit(repo: sl<SimilarRepo>())
                ..getSimilarMovies(id: model.id),
        ),
      ],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          MovieMainDetails(model: model),
          ButtonsRow(videoKey: trailerKey),
          verticalSpacing(20),
          AdditionalData(model: model),
          MovieStoryAndGenres(model: model),
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
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
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
                        AboutTabBody(),
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
