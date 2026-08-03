import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/models/poster_model.dart';

part 'see_all_web_services.g.dart';

@RestApi()
abstract class SeeAllWebServices {
  factory SeeAllWebServices(Dio dio, {String? baseUrl}) = _SeeAllWebServices;

  @GET("trending/{mediaType}/{timeWindow}")
  Future<PosterResponse> getTrending(
    @Path("mediaType") String mediaType,
    @Path("timeWindow") String timeWindow,
    @Query("page") int page,
  );

  @GET("movie/{category}")
  Future<PosterResponse> getMoviesByCategory(
    @Path("category") String category,
    @Query("page") int page,
  );

  @GET("tv/{category}")
  Future<PosterResponse> getTvByCategory(
    @Path("category") String category,
    @Query("page") int page,
  );

  @GET("movie/{id}/similar")
  Future<PosterResponse> getSimilarMovies(
    @Path("id") int id,
    @Query("page") int page,
  );

  @GET("tv/{id}/similar")
  Future<PosterResponse> getSimilarTv(
    @Path("id") int id,
    @Query("page") int page,
  );

  @GET("discover/movie")
  Future<PosterResponse> getMoviesByGenre(
    @Query("with_genres") int genreId,
    @Query("page") int page,
  );

  @GET("discover/tv")
  Future<PosterResponse> getTvByGenre(
    @Query("with_genres") int genreId,
    @Query("page") int page,
  );
}
