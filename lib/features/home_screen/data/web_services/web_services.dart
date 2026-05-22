import 'package:dio/dio.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/features/home_screen/data/model/poster_model.dart';
import 'package:retrofit/retrofit.dart';

part 'web_services.g.dart';

@RestApi()
abstract class WebServices {
  factory WebServices(Dio dio, {String? baseUrl}) = _WebServices;

  @GET(ApiConstants.trendingMedia)
  Future<PosterResponse> getTrendingMedia({
    @Query("language") String language = "en-US",
  });
}
