import 'package:movura/features/details_screen/data/models/about_model.dart';
import 'package:movura/features/details_screen/data/webs_services/about_services.dart';

class AboutRepo {
  final AboutServices aboutServices;

  AboutRepo(this.aboutServices);

  Future<AboutModel> getMovieMainDetails({required int movieId}) async {
    var response = await aboutServices.getMovieMainDetails(
      movieId: movieId,
      additionalData: "credits,images,videos",
    );

    return response;
  }
}
