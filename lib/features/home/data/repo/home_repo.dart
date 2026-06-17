import '../../../../core/models/poster_model.dart';
import '../web_services/home_web_services.dart';

class HomeRepo {
  final HomeWebServices homeWebServices;

  HomeRepo({required this.homeWebServices});

  Future<List<PosterModel>> getTrendingMedia() async {
    var response = await homeWebServices.getTrendingMedia();

    return response.results ?? [];
  }

  Future<List<PosterModel>> getTopRatedTvSeries() async {
    var response = await homeWebServices.getTopRatedTvSeries();

    return response.results ?? [];
  }

  Future<List<PosterModel>> getTopRatedMovies() async {
    var response = await homeWebServices.getTopRatedMovies();

    return response.results ?? [];
  }
}
