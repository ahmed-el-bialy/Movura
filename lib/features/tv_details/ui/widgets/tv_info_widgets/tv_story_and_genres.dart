import 'package:flutter/material.dart';
import 'package:movura/core/widgets/shared_details/details_story_and_genres.dart';
import '../../../data/about_tv_series_model.dart';

class TvStoryAndGenres extends StatelessWidget {
  const TvStoryAndGenres({super.key, required this.model});

  final AboutTvSeriesModel model;

  @override
  Widget build(BuildContext context) {
    return DetailsStoryAndGenres(
      overview: model.overview ?? '',
      genres: model.genres,
    );
  }
}
