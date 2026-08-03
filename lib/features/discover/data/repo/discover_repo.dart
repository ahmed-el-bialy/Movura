import 'package:movura/core/models/poster_model.dart';
import '../../../see_all/data/web_services/see_all_web_services.dart';

class DiscoverRepo {
  final SeeAllWebServices webServices;

  DiscoverRepo({required this.webServices});

  Future<List<PosterModel>> getTrendingMovies(String timeWindow) async {
    final response = await webServices.getTrending("movie", timeWindow, 1);
    return response.results ?? [];
  }

  Future<List<PosterModel>> getMoviesByCategory(String category) async {
    final response = await webServices.getMoviesByCategory(category, 1);
    return response.results ?? [];
  }

  Future<List<PosterModel>> getTrendingTv(String timeWindow) async {
    final response = await webServices.getTrending("tv", timeWindow, 1);
    return response.results ?? [];
  }

  Future<List<PosterModel>> getTvByCategory(String category) async {
    final response = await webServices.getTvByCategory(category, 1);
    return response.results ?? [];
  }

  Future<List<PosterModel>> getPopularPeople() async {
    final response = await webServices.getPopularPeople(1);
    return (response.results ?? []).map((e) => e.copyWith(mediaType: 'person')).toList();
  }

  Future<List<PosterModel>> getTrendingPeople(String timeWindow) async {
    final response = await webServices.getTrendingPeople(timeWindow, 1);
    return (response.results ?? []).map((e) => e.copyWith(mediaType: 'person')).toList();
  }
}
