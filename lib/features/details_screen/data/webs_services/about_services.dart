import 'package:dio/dio.dart';
import 'package:movura/features/details_screen/data/models/about_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/networking/api_constants.dart';

part 'about_services.g.dart';

@RestApi()
abstract class AboutServices {
  factory AboutServices(Dio dio, {String? baseUrl}) =
      _AboutServices;

  @GET(ApiConstants.movieDetails)
  Future<AboutModel> getMovieMainDetails({
    @Query("append_to_response") String additionalData = "credits,images",
    @Query("language") String language = "en-US",
    @Path("id") required int movieId,
  });
}
