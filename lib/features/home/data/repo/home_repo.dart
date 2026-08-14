import '../../../../core/models/poster_model.dart';
import '../web_services/home_web_services.dart';

class HomeRepo {
  final HomeWebServices homeWebServices;

  HomeRepo({required this.homeWebServices});

  Future<List<PosterModel>> getTrendingMedia({int page = 1}) async {
    var response = await homeWebServices.getTrendingMedia(page: page);

    return response.results?.map((e) => e.copyWith(mediaType: 'movie')).toList() ?? [];
  }

  Future<List<PosterModel>> getTopRatedTvSeries({int page = 1}) async {
    var response = await homeWebServices.getTopRatedTvSeries(page: page);

    return response.results?.map((e) => e.copyWith(mediaType: 'tv')).toList() ?? [];
  }

  Future<List<PosterModel>> getTopRatedMovies({int page = 1}) async {
    var response = await homeWebServices.getTopRatedMovies(page: page);

    return response.results?.map((e) => e.copyWith(mediaType: 'movie')).toList() ?? [];
  }
}
