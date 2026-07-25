import '../web_services/movie_web_services.dart';
import '../about_model.dart';
import '../../../../core/models/review_model.dart';
import '../../../../core/models/similar_model.dart';

class MovieRepo {
  final MovieWebServices movieWebServices;

  MovieRepo({required this.movieWebServices});

  Future<AboutModel> getMovieMainDetails({required int movieId}) async {
    return await movieWebServices.getMovieMainDetails(movieId: movieId);
  }

  Future<List<ReviewModel>> getMovieReviews({required int id}) async {
    final response = await movieWebServices.getMovieReviews(movieId: id);
    return response.reviewsList ?? [];
  }

  Future<SimilarContentResponse> getSimilarMovies({required int id}) async {
    return await movieWebServices.getSimilarMovies(movieId: id);
  }
}
