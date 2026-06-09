import '../../../../core/models/poster_model.dart';
import '../web_services/home_web_services.dart';

class TrendingContentRepo {
  final HomeWebServices webServices;

  TrendingContentRepo(this.webServices);

  Future<List<PosterModel>> getTrendingMedia() async {
    var response = await webServices.getTrendingMedia();

    return response.results ?? [];
  }
}
