import '../../models/shared_models/similar_model.dart';
import '../../webs_services/tv_web_services.dart';

class TvSimilarRepo {
  final TvWebServices detailsWebServices;

  TvSimilarRepo({required this.detailsWebServices});

  Future<SimilarContentResponse> getSimilarTvSeries({
    required int id,
  }) async {
    final response = await detailsWebServices.getSimilarTvSeries(
      id: id,
    );
    return response;
  }
}
