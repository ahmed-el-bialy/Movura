import 'package:movura/features/details_screen/data/models/review_model.dart';
import 'package:movura/features/details_screen/data/webs_services/details_web_services.dart';

class ReviewsRepo {
  final DetailsWebServices detailsWebServices;

  ReviewsRepo({required this.detailsWebServices});

  Future<List<ReviewModel>> getMovieReviews({required int movieId}) async {
    final response = await detailsWebServices.getMovieReviews(movieId: movieId);
    return response.reviewsList??[] ;
  }
}