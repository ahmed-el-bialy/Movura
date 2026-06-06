import 'package:movura/features/home_screen/data/web_services/trending_web_services.dart';

import '../../../../core/models/poster_model.dart';

class PostersRepo {
  final TrendingWebServices webServices;

  PostersRepo(this.webServices);

  Future<List<PosterModel>> getTrendingMedia() async {
    var response = await webServices.getTrendingMedia();

    return response.results ?? [];
  }
}
