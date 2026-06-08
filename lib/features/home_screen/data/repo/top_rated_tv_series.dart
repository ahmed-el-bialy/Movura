import 'package:movura/features/home_screen/data/web_services/home_web_services.dart';

import '../../../../core/models/poster_model.dart';

class TopRatedTvSeriesRepo {
  final HomeWebServices webServices;

  TopRatedTvSeriesRepo({required this.webServices});

  Future<List<PosterModel>> getTopRatedTvSeries() async {
    var response = await webServices.getTopRatedTvSeries();

    return response.results ?? [];
  }
}
