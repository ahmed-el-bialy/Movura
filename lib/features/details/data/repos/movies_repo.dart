import '../models/movie_models/about_model.dart';
import '../models/shared_models/review_model.dart';
import '../models/shared_models/similar_model.dart';
import '../webs_services/movie_web_services.dart';

class MovieRepo {
  final MovieWebServices movieWebServices;

  MovieRepo({required this.movieWebServices});

  Future<AboutModel> getMovieMainDetails({required int movieId}) async {
    var response = await movieWebServices.getMovieMainDetails(
      movieId: movieId,
      additionalData: "credits,images,videos",
    );

    return response;
  }

  Future<List<ReviewModel>> getMovieReviews({required int movieId}) async {
    final response = await movieWebServices.getMovieReviews(movieId: movieId);
    return response.reviewsList ?? [];
  }

  Future<SimilarContentResponse> getSimilarMovies({
    required int movieId,
  }) async {
    final response = await movieWebServices.getSimilarMovies(movieId: movieId);
    return response;
  }
}
