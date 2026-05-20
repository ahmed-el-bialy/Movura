import 'package:movura/features/details_screen/data/models/main_details_model.dart';
import 'package:movura/features/details_screen/data/webs_services/main_details_services.dart';

class MainDetailsRepo {
  final MainDetailsServices mainDetailsServices;

  MainDetailsRepo(this.mainDetailsServices);

  Future<MainDetailsModel> getMovieMainDetails({required int movieId}) async {
    var response = await mainDetailsServices.getMovieMainDetails(
      movieId: movieId,
    );

    return response;
  }
}
