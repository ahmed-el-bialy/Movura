import 'package:flutter/material.dart';
import '../../../../../core/widgets/shared_details/details_story_and_genres.dart';
import '../../../data/models/about_model.dart';

class MovieStoryAndGenres extends StatelessWidget {
  const MovieStoryAndGenres({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    return DetailsStoryAndGenres(
      overview: model.overview ?? '',
      genres: model.genres,
    );
  }
}
