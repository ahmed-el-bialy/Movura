import '../../models/shared_models/similar_model.dart';
import '../../webs_services/movie_web_services.dart';

class SimilarRepo {
  final MovieWebServices detailsWebServices;

  SimilarRepo({required this.detailsWebServices});

  Future<SimilarContentResponse> getSimilarMovies({required int movieId}) async {
    final response = await detailsWebServices.getSimilarMovies(
      movieId: movieId,
    );
    return response;
  }
}
