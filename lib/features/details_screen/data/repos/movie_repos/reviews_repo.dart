
import '../../models/movie_models/review_model.dart';
import '../../webs_services/movie_web_services.dart';

class ReviewsRepo {
  final MovieWebServices detailsWebServices;

  ReviewsRepo({required this.detailsWebServices});

  Future<List<ReviewModel>> getMovieReviews({required int movieId}) async {
    final response = await detailsWebServices.getMovieReviews(movieId: movieId);
    return response.reviewsList ?? [];
  }
}
