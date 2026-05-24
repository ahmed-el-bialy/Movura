import 'package:movura/features/details_screen/data/models/review_model.dart';
import 'package:movura/features/details_screen/data/webs_services/about_services.dart';

class ReviewsRepo {
  final AboutServices aboutServices;

  ReviewsRepo({required this.aboutServices});

  Future<ReviewsResponse> getMovieReviews({required int movieId}) async {
    final response = await aboutServices.getMovieReviews(movieId: movieId);
    return response;
  }
}