import 'package:material_ui/material_ui.dart';
import 'package:movura/core/routing/route_names.dart';

import '../../../../../core/networking/di.dart';
import '../../../../../core/widgets/shared_details/details_story_and_genres.dart';
import '../../../../../features/see_all/data/models/see_all_arguments.dart';
import '../../../../discover/data/repo/discover_repo.dart';
import '../../../data/models/about_model.dart';

class MovieStoryAndGenres extends StatelessWidget {
  const MovieStoryAndGenres({super.key, required this.model});

  final AboutModel model;

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
            fetchData: (page) => discoverRepo.getMoviesByGenre(id, page: page),
          ),
        );
      },
    );
  }
}
