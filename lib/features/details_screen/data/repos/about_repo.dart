import 'package:movura/features/details_screen/data/models/about_model.dart';
import 'package:movura/features/details_screen/data/webs_services/about_services.dart';

class AboutRepo {
  final AboutServices mainDetailsServices;

  AboutRepo(this.mainDetailsServices);

  Future<AboutModel> getMovieMainDetails({required int movieId}) async {
    var response = await mainDetailsServices.getMovieMainDetails(
      movieId: movieId,
    );

    return response;
  }
}
