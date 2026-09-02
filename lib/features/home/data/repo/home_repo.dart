import '../../../../core/models/poster_model.dart';
import '../web_services/home_web_services.dart';

class HomeRepo {
  final HomeWebServices homeWebServices;

  final Map<int, List<PosterModel>> _trendingCache = {};
  final Map<int, List<PosterModel>> _trendingWeeklyCache = {};
  final Map<int, List<PosterModel>> _topMoviesCache = {};
  final Map<int, List<PosterModel>> _topTvCache = {};

  HomeRepo({required this.homeWebServices});

  Future<List<PosterModel>> getTrendingMedia({int page = 1}) async {
    if (_trendingCache.containsKey(page)) {
      return _trendingCache[page]!;
    }
    var response = await homeWebServices.getTrendingMedia(page: page);
    final results =
        response.results?.map((e) => e.copyWith(mediaType: e.mediaType ?? 'movie')).toList() ??
            [];
    if (results.isNotEmpty) {
      _trendingCache[page] = results;
    }
    return results;
  }

  Future<List<PosterModel>> getTrendingWeekly({int page = 1}) async {
    if (_trendingWeeklyCache.containsKey(page)) {
      return _trendingWeeklyCache[page]!;
    }
    var response = await homeWebServices.getTrendingWeekly(page: page);
    final results =
        response.results?.map((e) => e.copyWith(mediaType: e.mediaType ?? 'movie')).toList() ??
            [];
    if (results.isNotEmpty) {
      _trendingWeeklyCache[page] = results;
    }
    return results;
  }

  Future<List<PosterModel>> getTopRatedTvSeries({int page = 1}) async {
    if (_topTvCache.containsKey(page)) {
      return _topTvCache[page]!;
    }
    var response = await homeWebServices.getTopRatedTvSeries(page: page);
    final results =
        response.results?.map((e) => e.copyWith(mediaType: 'tv')).toList() ??
            [];
    if (results.isNotEmpty) {
      _topTvCache[page] = results;
    }
    return results;
  }

  Future<List<PosterModel>> getTopRatedMovies({int page = 1}) async {
    if (_topMoviesCache.containsKey(page)) {
      return _topMoviesCache[page]!;
    }
    var response = await homeWebServices.getTopRatedMovies(page: page);
    final results =
        response.results?.map((e) => e.copyWith(mediaType: 'movie')).toList() ??
            [];
    if (results.isNotEmpty) {
      _topMoviesCache[page] = results;
    }
    return results;
  }
}
