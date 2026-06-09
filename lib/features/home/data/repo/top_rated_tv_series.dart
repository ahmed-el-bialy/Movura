import '../../../../core/models/poster_model.dart';
import '../web_services/home_web_services.dart';

class TopRatedTvSeriesRepo {
  final HomeWebServices webServices;

  TopRatedTvSeriesRepo({required this.webServices});

  Future<List<PosterModel>> getTopRatedTvSeries() async {
    var response = await webServices.getTopRatedTvSeries();

    return response.results ?? [];
  }
}
