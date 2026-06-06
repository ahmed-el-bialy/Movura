import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/utils/constants/api_constants.dart';
import '../models/tv_models/about_tv_series_model.dart';

part 'tv_web_services.g.dart';

@RestApi()
abstract class TvWebServices {
  factory TvWebServices(Dio dio, {String? baseUrl}) = _TvWebServices;

  @GET("${ApiConstants.tvDetails}/{id}")
  Future<AboutTvSeriesModel> getTvSeriesMainDetails({
    @Path("id") required int movieId,
    @Query("append_to_response")
    String additionalData = "credits,images,videos",
    @Query("language") String language = "en-US",
  });

  // @GET("${ApiConstants.movieDetails}/{id}/reviews")
  // Future<ReviewsResponse> getMovieReviews({
  //   @Path("id") required int movieId,
  //   @Query("language") String language = "en-US",
  // });

  // @GET("${ApiConstants.movieDetails}/{id}")
  // Future<SimilarMovieResponse> getSimilarMovies({
  //   @Path("id") required int movieId,
  //   @Query("append_to_response")
  //   String additionalData = "similar,recommendations",
  //   @Query("language") String language = "en-US",
  // });
}
