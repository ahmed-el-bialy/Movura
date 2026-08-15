import 'package:flutter/material.dart';
import 'package:movura/core/routing/route_names.dart';
import 'package:movura/core/widgets/shared_details/details_story_and_genres.dart';
import '../../../../../features/see_all/data/models/see_all_arguments.dart';
import '../../../data/about_tv_series_model.dart';
import '../../../../../core/networking/di.dart';
import '../../../../discover/data/repo/discover_repo.dart';

class TvStoryAndGenres extends StatelessWidget {
  const TvStoryAndGenres({super.key, required this.model});

  final AboutTvSeriesModel model;

  @override
  Widget build(BuildContext context) {
    final discoverRepo = sl<DiscoverRepo>();

    return DetailsStoryAndGenres(
      overview: model.overview ?? '',
      genres: model.genres,
      onGenreTap: (id, name) {
        Navigator.pushNamed(
          context,
          RouteNames.seeAllScreen,
          arguments: SeeAllArguments(
            title: name,
            fetchData: (page) => discoverRepo.getTvByGenre(id, page: page),
          ),
        );
      },
    );
  }
}
