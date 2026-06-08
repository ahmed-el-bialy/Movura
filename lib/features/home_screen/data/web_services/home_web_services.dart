import 'package:dio/dio.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/utils/constants/api_constants.dart';
import 'package:retrofit/retrofit.dart';

part 'home_web_services.g.dart';

@RestApi()
abstract class HomeWebServices {
  factory HomeWebServices(Dio dio, {String? baseUrl}) = _HomeWebServices;

  // الـ Request الخاص بالـ Trending Content اللي شغال معاك فوق
  @GET(ApiConstants.trendingMedia)
  Future<PosterResponse> getTrendingMedia({
    @Query("language") String language = "en-US",
  });

  // 🔥 الـ Request الخاص بالـ Top Rated Movies بعد ضبط الـ Path الصافي
  @GET(ApiConstants.topRatedMovies)
  Future<PosterResponse> getTopRatedMovies({
    @Query("language") String language = "en-US",
  });
}