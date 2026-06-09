import 'package:movura/features/details/data/models/tv_models/about_tv_series_model.dart';

import '../../webs_services/tv_web_services.dart';

class AboutTvSeriesRepo {
  final TvWebServices tvWebServices;

  AboutTvSeriesRepo(this.tvWebServices);

  Future<AboutTvSeriesModel> getTvSeriesMainDetails({
    required int movieId,
  }) async {
    var response = await tvWebServices.getTvSeriesMainDetails(
      id: movieId,
      additionalData: "credits,images,videos",
    );

    return response;
  }
}
