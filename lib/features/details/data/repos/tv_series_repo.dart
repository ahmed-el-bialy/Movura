import 'package:movura/features/details/data/models/tv_models/about_tv_series_model.dart';

import '../models/shared_models/review_model.dart';
import '../models/shared_models/similar_model.dart';
import '../webs_services/tv_web_services.dart';

class TvSeriesRepo {
  final TvWebServices tvWebServices;

  TvSeriesRepo({required this.tvWebServices});

  Future<AboutTvSeriesModel> getTvSeriesMainDetails({
    required int movieId,
  }) async {
    var response = await tvWebServices.getTvSeriesMainDetails(
      id: movieId,
      additionalData: "credits,images,videos",
    );

    return response;
  }

  Future<List<ReviewModel>> getTvSeriesReviews({required int id}) async {
    final response = await tvWebServices.getTvSeriesReviews(id: id);
    return response.reviewsList ?? [];
  }

  Future<SimilarContentResponse> getSimilarTvSeries({required int id}) async {
    final response = await tvWebServices.getSimilarTvSeries(id: id);
    return response;
  }
}
