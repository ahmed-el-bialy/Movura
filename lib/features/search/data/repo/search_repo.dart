import 'package:movura/features/search/data/web_services/search_web_services.dart';

import '../../../../core/models/poster_model.dart';

class SearchRepo {
  final SearchWebServices searchWebServices;

  SearchRepo({required this.searchWebServices});

  Future<List<PosterModel>> getSearchResults({
    required String query,
    required int page,
  }) async {
    var response = await searchWebServices.getSearchResults(
      query: query,
      page: page,
    );
    return response.results ?? [];
  }
}
