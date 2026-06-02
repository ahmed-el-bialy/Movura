import '../models/about_model.dart';
import '../webs_services/details_web_services.dart';

class AboutRepo {
  final DetailsWebServices detailsWebServices;

  AboutRepo(this.detailsWebServices);

  Future<AboutModel> getMovieMainDetails({required int movieId}) async {
    var response = await detailsWebServices.getMovieMainDetails(
      movieId: movieId,
      additionalData: "credits,images,videos",
    );

    return response;
  }
}
