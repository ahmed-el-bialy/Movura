import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/networking/di.dart';
import '../../../data/models/movie_models/about_model.dart';
import '../../../logic/movie_screen_cubit/reviews/reviews_cubit.dart';
import '../../../logic/movie_screen_cubit/similar_content/similar_content_cubit.dart';
import '../shared_widgets/buttons_row.dart';
import 'about_tab_body.dart';
import 'movie_main_details.dart';
import 'movie_reviews_tab_body.dart';
import 'similar_tab_body.dart';
import 'sub_widgets/movie_additional_data.dart';
import 'sub_widgets/movie_story_and_genres.dart';

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
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<ReviewsCubit>(
          create: (context) =>
              sl<ReviewsCubit>()
                ..getMovieReviews(id: model.id),
        ),

        BlocProvider<SimilarContentCubit>(
          create: (context) =>
              sl<SimilarContentCubit>()
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
                      unselectedLabelStyle: AppTextStyles.font10MediumCoolGraySora
                          .copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
                      labelStyle: AppTextStyles.font13BoldNeonBlueSora,
                      indicatorColor: AppColors.neonBlue,
                      indicatorWeight: 3.0,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: AppColors.neonBlue,
                      unselectedLabelColor: AppColors.slateGray,
                      tabs: const [
                        Tab(text: "ABOUT"),
                        Tab(text: "REVIEWS"),
                        Tab(text: "SIMILAR"),
                      ],
                    ),
                    verticalSpacing(10),
                    ExpandablePageView(
                      controller: pageController,
                      onPageChanged: (index) {
                        tabController.animateTo(index);
                      },
                      children: [
                        AboutTabBody(),
                        MovieReviewsTabBody(),
                        MovieSimilarTabBody(),
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
