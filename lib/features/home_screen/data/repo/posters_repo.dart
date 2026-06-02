import '../../../shared/data/models/poster_model.dart';
import '../movie_web_services/web_services.dart';

class PostersRepo {
  final MovieWebServices webServices;

  PostersRepo(this.webServices);

  Future<List<PosterModel>> getTrendingMedia() async {
    var response = await webServices.getTrendingMedia();

    return response.results ?? [];
  }
}
