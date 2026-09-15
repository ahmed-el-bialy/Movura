import '../../../../core/models/poster_model.dart';
import '../../../home/data/web_services/home_web_services.dart';
import '../web_services/discover_web_services.dart';

class DiscoverRepo {
  final DiscoverWebServices webServices;

  DiscoverRepo({required this.webServices});

  Future<List<PosterModel>> getTrendingMovies(
    String timeWindow, {
    int page = 1,
  }) async {
    try {
      final response = await webServices
          .getTrending(mediaType: "movie", timeWindow: timeWindow, page: page)
          .timeout(const Duration(seconds: 15));
      return (response.results ?? [])
          .map((e) => e.copyWith(mediaType: 'movie'))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PosterModel>> getMoviesByCategory(
    String category, {
    int page = 1,
  }) async {
    try {
      final response = await webServices
          .getMoviesByCategory(category: category, page: page)
          .timeout(const Duration(seconds: 15));
      return (response.results ?? [])
          .map((e) => e.copyWith(mediaType: 'movie'))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PosterModel>> getTrendingTv(
    String timeWindow, {
    int page = 1,
  }) async {
    try {
      final response = await webServices
          .getTrending(mediaType: "tv", timeWindow: timeWindow, page: page)
          .timeout(const Duration(seconds: 15));
      return (response.results ?? [])
          .map((e) => e.copyWith(mediaType: 'tv'))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PosterModel>> getTvByCategory(
    String category, {
    int page = 1,
  }) async {
    try {
      final response = await webServices
          .getTvByCategory(category: category, page: page)
          .timeout(const Duration(seconds: 15));
      return (response.results ?? [])
          .map((e) => e.copyWith(mediaType: 'tv'))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PosterModel>> getPopularPeople({int page = 1}) async {
    try {
      final response = await webServices
          .getPopularPeople(page: page)
          .timeout(const Duration(seconds: 15));
      return (response.results ?? [])
          .map((e) => e.copyWith(mediaType: 'person'))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PosterModel>> getTrendingPeople(
    String timeWindow, {
    int page = 1,
  }) async {
    try {
      final response = await webServices
          .getTrendingPeople(timeWindow: timeWindow, page: page)
          .timeout(const Duration(seconds: 15));
      return (response.results ?? [])
          .map((e) => e.copyWith(mediaType: 'person'))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PosterModel>> getMoviesByGenre(
    int genreId, {
    int page = 1,
  }) async {
    try {
      final response = await webServices
          .getMoviesByGenre(genreId: genreId, page: page)
          .timeout(const Duration(seconds: 15));
      return (response.results ?? [])
          .map((e) => e.copyWith(mediaType: 'movie'))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PosterModel>> getTvByGenre(int genreId, {int page = 1}) async {
    try {
      final response = await webServices
          .getTvByGenre(genreId: genreId, page: page)
          .timeout(const Duration(seconds: 15));
      return (response.results ?? [])
          .map((e) => e.copyWith(mediaType: 'tv'))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<GenreResponse> getMovieGenres() async {
    try {
      return await webServices.getMovieGenres().timeout(
        const Duration(seconds: 15),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<GenreResponse> getTvGenres() async {
    try {
      return await webServices.getTvGenres().timeout(
        const Duration(seconds: 15),
      );
    } catch (e) {
      rethrow;
    }
  }
}
