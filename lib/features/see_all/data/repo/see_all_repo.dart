import '../../../../core/models/poster_model.dart';
import '../models/see_all_arguments.dart';
import '../web_services/see_all_web_services.dart';

class SeeAllRepo {
  final SeeAllWebServices webServices;

  SeeAllRepo({required this.webServices});

  Future<List<PosterModel>> getSeeAllData({
    required SeeAllEndpoint endpoint,
    required int page,
    int? id,
  }) async {
    PosterResponse response;
    String mediaType = '';

    switch (endpoint) {
      case SeeAllEndpoint.trendingMoviesDay:
        response = await webServices.getTrending("movie", "day", page);
        mediaType = 'movie';
        break;
      case SeeAllEndpoint.trendingMoviesWeek:
        response = await webServices.getTrending("movie", "week", page);
        mediaType = 'movie';
        break;
      case SeeAllEndpoint.popularMovies:
        response = await webServices.getMoviesByCategory("popular", page);
        mediaType = 'movie';
        break;
      case SeeAllEndpoint.topRatedMovies:
        response = await webServices.getMoviesByCategory("top_rated", page);
        mediaType = 'movie';
        break;
      case SeeAllEndpoint.upcomingMovies:
        response = await webServices.getMoviesByCategory("upcoming", page);
        mediaType = 'movie';
        break;
      case SeeAllEndpoint.nowPlayingMovies:
        response = await webServices.getMoviesByCategory("now_playing", page);
        mediaType = 'movie';
        break;
      case SeeAllEndpoint.trendingTvDay:
        response = await webServices.getTrending("tv", "day", page);
        mediaType = 'tv';
        break;
      case SeeAllEndpoint.trendingTvWeek:
        response = await webServices.getTrending("tv", "week", page);
        mediaType = 'tv';
        break;
      case SeeAllEndpoint.popularTv:
        response = await webServices.getTvByCategory("popular", page);
        mediaType = 'tv';
        break;
      case SeeAllEndpoint.topRatedTv:
        response = await webServices.getTvByCategory("top_rated", page);
        mediaType = 'tv';
        break;
      case SeeAllEndpoint.onTheAirTv:
        response = await webServices.getTvByCategory("on_the_air", page);
        mediaType = 'tv';
        break;
      case SeeAllEndpoint.similarMovies:
        response = await webServices.getSimilarMovies(id!, page);
        mediaType = 'movie';
        break;
      case SeeAllEndpoint.similarTv:
        response = await webServices.getSimilarTv(id!, page);
        mediaType = 'tv';
        break;
      case SeeAllEndpoint.moviesByGenre:
        response = await webServices.getMoviesByGenre(id!, page);
        mediaType = 'movie';
        break;
      case SeeAllEndpoint.tvByGenre:
        response = await webServices.getTvByGenre(id!, page);
        mediaType = 'tv';
        break;
      case SeeAllEndpoint.popularPeople:
        response = await webServices.getPopularPeople(page);
        mediaType = 'person';
        break;
      case SeeAllEndpoint.trendingPeople:
        response = await webServices.getTrendingPeople("day", page);
        mediaType = 'person';
        break;
    }

    // Force media type if not provided by the API directly
    var results = response.results ?? [];
    if (mediaType.isNotEmpty) {
      results = results.map((e) => e.copyWith(mediaType: mediaType)).toList();
    }

    return results;
  }
}
