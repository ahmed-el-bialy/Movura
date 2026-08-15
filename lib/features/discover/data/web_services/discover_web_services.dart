import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/models/poster_model.dart';

part 'discover_web_services.g.dart';

@RestApi()
abstract class DiscoverWebServices {
  factory DiscoverWebServices(Dio dio, {String? baseUrl}) = _DiscoverWebServices;

  @GET("trending/{mediaType}/{timeWindow}")
  Future<PosterResponse> getTrending({
    @Path("mediaType") required String mediaType,
    @Path("timeWindow") required String timeWindow,
    @Query("page") required int page,
  });

  @GET("movie/{category}")
  Future<PosterResponse> getMoviesByCategory({
    @Path("category") required String category,
    @Query("page") required int page,
  });

  @GET("tv/{category}")
  Future<PosterResponse> getTvByCategory({
    @Path("category") required String category,
    @Query("page") required int page,
  });

  @GET("discover/movie")
  Future<PosterResponse> getMoviesByGenre({
    @Query("with_genres") required int genreId,
    @Query("page") required int page,
  });

  @GET("discover/tv")
  Future<PosterResponse> getTvByGenre({
    @Query("with_genres") required int genreId,
    @Query("page") required int page,
  });

  @GET("person/popular")
  Future<PosterResponse> getPopularPeople({
    @Query("page") required int page,
  });

  @GET("trending/person/{timeWindow}")
  Future<PosterResponse> getTrendingPeople({
    @Path("timeWindow") required String timeWindow,
    @Query("page") required int page,
  });
}
