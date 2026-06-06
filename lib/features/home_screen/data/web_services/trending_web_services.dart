import 'package:dio/dio.dart';
import 'package:movura/core/utils/constants/api_constants.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:retrofit/retrofit.dart';

part 'trending_web_services.g.dart';

@RestApi()
abstract class TrendingWebServices {
  factory TrendingWebServices(Dio dio, {String? baseUrl}) = _TrendingWebServices;

  @GET(ApiConstants.trendingMedia)
  Future<PosterResponse> getTrendingMedia({
    @Query("language") String language = "en-US",
  });
}
