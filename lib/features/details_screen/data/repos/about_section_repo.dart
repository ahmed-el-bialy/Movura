import '../models/about_model.dart';
import '../webs_services/about_section_services.dart';

class AboutSectionRepo {
  final AboutSectionServices aboutSectionServices;

  AboutSectionRepo({required this.aboutSectionServices});

  Future<AboutModel> getMovieMainDetails(int movieId) async {
    var response = aboutSectionServices.getAboutSectionData(movieId: movieId);

    return response;
  }
}
