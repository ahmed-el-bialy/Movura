import 'package:movura/features/details_screen/data/webs_services/tv_web_services.dart';

import '../../models/shared_models/review_model.dart';

class TvReviewsRepo {
  final TvWebServices detailsWebServices;

  TvReviewsRepo({required this.detailsWebServices});

  Future<List<ReviewModel>> getTvSeriesReviews({required int id}) async {
    final response = await detailsWebServices.getTvSeriesReviews(id: id);
    return response.reviewsList ?? [];
  }
}
