import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/features/tv_details/ui/widgets/reviews_tab_body.dart';
import 'package:movura/features/tv_details/ui/widgets/similar_tab_body.dart';
import 'package:movura/features/tv_details/ui/widgets/tv_info_widgets/tv_additional_data.dart';
import 'package:movura/features/tv_details/ui/widgets/tv_info_widgets/tv_story_and_genres.dart';
import 'package:movura/features/tv_details/ui/widgets/tv_main_details.dart';

import 'package:movura/core/networking/di.dart';
import 'package:movura/core/widgets/shared_details/buttons_row.dart';
import 'package:movura/core/widgets/shared_details/details_tabs.dart';
import '../../data/about_tv_series_model.dart';
import '../../logic/reviews/reviews_cubit.dart';
import '../../logic/similar_content/similar_content_cubit.dart';
import 'about_tv_tab_body.dart';

class TvScreenBody extends StatelessWidget {
  const TvScreenBody({super.key, required this.model});

  final AboutTvSeriesModel model;

  @override
  Widget build(BuildContext context) {
    String? trailerKey;
    final videos = model.tvVideos?.videoList;

    if (videos != null && videos.isNotEmpty) {
      final trailer = videos.firstWhere(
        (v) => v.type?.toLowerCase() == 'trailer',
        orElse: () => videos.first,
      );
      trailerKey = trailer.key;
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesReviewsCubit>(
          create: (context) =>
              sl<TvSeriesReviewsCubit>()..getTvSeriesReviews(id: model.id),
        ),
        BlocProvider<TvSeriesSimilarContentCubit>(
          create: (context) =>
              sl<TvSeriesSimilarContentCubit>()
                ..getSimilarTvSeries(id: model.id),
        ),
      ],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          TvMainDetails(model: model),
          ButtonsRow(videoKey: trailerKey),
          AppSpacing.verticalSpacing(20),
          TvAdditionalData(model: model),
          TvStoryAndGenres(model: model),
          AppSpacing.verticalSpacing(10),
          DetailsTabs(
            tabs: const ["ABOUT", "REVIEWS", "SIMILAR"],
            children: const [
              AboutTvTabBody(),
              ReviewsTabBody(),
              SimilarTabBody(),
            ],
          ),
        ],
      ),
    );
  }
}
