import 'package:movura/features/search/data/web_services/search_web_services.dart';

import '../../../../core/models/poster_model.dart';
import 'package:movura/features/search/data/models/search_filter_type.dart';

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
      case SearchFilterType.movie:
        response = await searchWebServices.getMovieSearchResults(query: query, page: page);
        break;
      case SearchFilterType.tv:
        response = await searchWebServices.getTvSearchResults(query: query, page: page);
        break;
      case SearchFilterType.person:
        response = await searchWebServices.getPersonSearchResults(query: query, page: page);
        break;
      case SearchFilterType.all:
      default:
        response = await searchWebServices.getMultiSearchResults(query: query, page: page);
        break;
    }

    var results = response.results ?? [];
    if (filterType == SearchFilterType.movie) {
      results = results.map((e) => e.copyWith(mediaType: 'movie')).toList();
    } else if (filterType == SearchFilterType.tv) {
      results = results.map((e) => e.copyWith(mediaType: 'tv')).toList();
    } else if (filterType == SearchFilterType.person) {
      results = results.map((e) => e.copyWith(mediaType: 'person')).toList();
    }

    return results;
  }
}
