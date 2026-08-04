import 'package:flutter/material.dart';
import 'package:movura/core/routing/route_names.dart';
import '../../../../../core/widgets/shared_details/details_story_and_genres.dart';
import '../../../../see_all/data/models/see_all_arguments.dart';
import '../../../data/models/about_model.dart';

class MovieStoryAndGenres extends StatelessWidget {
  const MovieStoryAndGenres({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    return DetailsStoryAndGenres(
      overview: model.overview ?? '',
      genres: model.genres,
      onGenreTap: (id, name) {
        Navigator.pushNamed(
          context,
          RouteNames.seeAllScreen,
          arguments: SeeAllArguments(
            title: name,
            endpoint: SeeAllEndpoint.moviesByGenre,
            id: id,
          ),
        );
      },
    );
  }
}
