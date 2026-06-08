import 'package:movura/features/home_screen/data/web_services/home_web_services.dart';

import '../../../../core/models/poster_model.dart';

class TopRatedMoviesRepo {
  final HomeWebServices webServices;

  TopRatedMoviesRepo({required this.webServices});

  Future<List<PosterModel>> getTopRatedMovies() async {
    var response = await webServices.getTopRatedMovies();

    return response.results ?? [];
  }
}
