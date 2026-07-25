import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../../core/constants/api_constants.dart';
import '../about_model.dart';
import '../../../../core/models/review_model.dart';
import '../../../../core/models/similar_model.dart';

part 'movie_web_services.g.dart';

@RestApi()
abstract class MovieWebServices {
  factory MovieWebServices(Dio dio, {String? baseUrl}) = _MovieWebServices;

  @GET("${ApiConstants.movieDetails}/{id}")
  Future<AboutModel> getMovieMainDetails({
    @Path("id") required int movieId,
    @Query("append_to_response")
    String additionalData = "credits,images,videos,watch/providers",
    @Query("language") String language = "en-US",
  });

  @GET("${ApiConstants.movieDetails}/{id}/reviews")
  Future<ReviewsResponse> getMovieReviews({
    @Path("id") required int movieId,
    @Query("language") String language = "en-US",
  });

  @GET("${ApiConstants.movieDetails}/{id}")
  Future<SimilarContentResponse> getSimilarMovies({
    @Path("id") required int movieId,
    @Query("append_to_response")
    String additionalData = "similar,recommendations",
    @Query("language") String language = "en-US",
  });
}
