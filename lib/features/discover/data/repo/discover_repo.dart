import '../../../../core/models/poster_model.dart';
import '../web_services/discover_web_services.dart';

class DiscoverRepo {
  final DiscoverWebServices webServices;

  DiscoverRepo({required this.webServices});

  Future<List<PosterModel>> getTrendingMovies(String timeWindow, {int page = 1}) async {
    final response = await webServices.getTrending(
      mediaType: "movie",
      timeWindow: timeWindow,
      page: page,
    );
    return response.results ?? [];
  }

  Future<List<PosterModel>> getMoviesByCategory(String category, {int page = 1}) async {
    final response = await webServices.getMoviesByCategory(
      category: category,
      page: page,
    );
    return response.results ?? [];
  }

  Future<List<PosterModel>> getTrendingTv(String timeWindow, {int page = 1}) async {
    final response = await webServices.getTrending(
      mediaType: "tv",
      timeWindow: timeWindow,
      page: page,
    );
    return response.results ?? [];
  }

  Future<List<PosterModel>> getTvByCategory(String category, {int page = 1}) async {
    final response = await webServices.getTvByCategory(
      category: category,
      page: page,
    );
    return response.results ?? [];
  }

  Future<List<PosterModel>> getPopularPeople({int page = 1}) async {
    final response = await webServices.getPopularPeople(page: page);
    return (response.results ?? [])
        .map((e) => e.copyWith(mediaType: 'person'))
        .toList();
  }

  Future<List<PosterModel>> getTrendingPeople(String timeWindow, {int page = 1}) async {
    final response = await webServices.getTrendingPeople(
      timeWindow: timeWindow,
      page: page,
    );
    return (response.results ?? [])
        .map((e) => e.copyWith(mediaType: 'person'))
        .toList();
  }

  Future<List<PosterModel>> getMoviesByGenre(int genreId, {int page = 1}) async {
    final response = await webServices.getMoviesByGenre(
      genreId: genreId,
      page: page,
    );
    return response.results ?? [];
  }

  Future<List<PosterModel>> getTvByGenre(int genreId, {int page = 1}) async {
    final response = await webServices.getTvByGenre(
      genreId: genreId,
      page: page,
    );
    return response.results ?? [];
  }
}
