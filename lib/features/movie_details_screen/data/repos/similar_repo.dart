import '../models/similar_model.dart';
import '../webs_services/details_web_services.dart';

class SimilarRepo {
  final DetailsWebServices detailsWebServices;

  SimilarRepo({required this.detailsWebServices});

  Future<SimilarMovieResponse> getSimilarMovies({required int movieId}) async {
    final response = await detailsWebServices.getSimilarMovies(
      movieId: movieId,
    );
    return response;
  }
}
