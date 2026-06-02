import 'package:dio/dio.dart';
import 'package:movura/core/utils/constants/api_constants.dart';
import 'package:movura/features/shared/data/models/poster_model.dart';
import 'package:retrofit/retrofit.dart';

part 'web_services.g.dart';

@RestApi()
abstract class MovieWebServices {
  factory MovieWebServices(Dio dio, {String? baseUrl}) = _WebServices;

  @GET(ApiConstants.trendingMedia)
  Future<PosterResponse> getTrendingMedia({
    @Query("language") String language = "en-US",
  });
}
