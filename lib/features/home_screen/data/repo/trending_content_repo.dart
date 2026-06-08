import 'package:movura/features/home_screen/data/web_services/trending_web_services.dart';

import '../../../../core/models/poster_model.dart';

class TrendingContentRepo {
  final TrendingWebServices webServices;

  TrendingContentRepo(this.webServices);

  Future<List<PosterModel>> getTrendingMedia() async {
    var response = await webServices.getTrendingMedia();

    return response.results ?? [];
  }
}
