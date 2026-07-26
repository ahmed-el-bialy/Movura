import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/networking/di.dart';
import 'package:movura/core/widgets/shared_details/buttons_row.dart';
import 'package:movura/core/widgets/shared_details/details_tabs.dart';
import 'package:movura/features/movie_details/data/models/about_model.dart';
import 'package:movura/features/movie_details/logic/reviews/reviews_cubit.dart';
import 'package:movura/features/movie_details/logic/similar_content/similar_content_cubit.dart';

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
          verticalSpacing(30),
          AdditionalData(model: model),
          verticalSpacing(20),
          MovieStoryAndGenres(model: model),
          verticalSpacing(10),
          DetailsTabs(
            tabs: const ["ABOUT", "REVIEWS", "SIMILAR"],
            children: const [
              AboutTabBody(),
              MovieReviewsTabBody(),
              MovieSimilarTabBody(),
            ],
          ),
        ],
      ),
    );
  }
}
