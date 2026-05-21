import 'package:dio/dio.dart';
import 'package:movura/core/networking/api_constants.dart';
import 'package:movura/features/details_screen/data/models/about_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'about_section_services.g.dart';

@RestApi()
abstract class AboutSectionServices {
  factory AboutSectionServices(Dio dio, {String? baseUrl}) =
      _AboutSectionServices;

  @GET(ApiConstants.movieDetails)
  Future<AboutModel> getAboutSectionData({
    @Query("language") String language = "en-US",
    @Path("id") required int movieId,
  });
}
