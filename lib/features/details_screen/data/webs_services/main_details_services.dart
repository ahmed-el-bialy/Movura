import 'package:dio/dio.dart';
import 'package:movura/features/details_screen/data/models/main_details_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/networking/api_constants.dart';

part 'main_details_services.g.dart';

@RestApi()
abstract class MainDetailsServices {
  factory MainDetailsServices(Dio dio, {String? baseUrl}) =
      _MainDetailsServices;

  @GET(ApiConstants.movieDetails)
  Future<MainDetailsModel> getMovieMainDetails({
    @Query("language") String language = "en-US",
    @Path("id") required int movieId,
  });
}
