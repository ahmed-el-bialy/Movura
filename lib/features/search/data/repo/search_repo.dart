import '../../../../core/models/poster_model.dart';
import '../models/search_filter_type.dart';
import '../web_services/search_web_services.dart';

class SearchRepo {
  final SearchWebServices searchWebServices;

  SearchRepo({required this.searchWebServices});

  Future<List<PosterModel>> getSearchResults({
    required String query,
    required SearchFilterType filterType,
    int? page,
  }) async {
    PosterResponse response;
    switch (filterType) {
      case SearchFilterType.movies:
        response = await searchWebServices.getMovieSearchResults(
          query: query,
          page: page,
        );
        break;
      case SearchFilterType.tv:
        response = await searchWebServices.getTvSearchResults(
          query: query,
          page: page,
        );
        break;
      case SearchFilterType.people:
        response = await searchWebServices.getPersonSearchResults(
          query: query,
          page: page,
        );
        break;
      case SearchFilterType.all:
        response = await searchWebServices.getMultiSearchResults(
          query: query,
          page: page,
        );
        break;
    }

    var results = response.results ?? [];
    if (filterType == SearchFilterType.movies) {
      results = results.map((e) => e.copyWith(mediaType: 'movie')).toList();
    } else if (filterType == SearchFilterType.tv) {
      results = results.map((e) => e.copyWith(mediaType: 'tv')).toList();
    } else if (filterType == SearchFilterType.people) {
      results = results.map((e) => e.copyWith(mediaType: 'person')).toList();
    }

    return results;
  }
}
