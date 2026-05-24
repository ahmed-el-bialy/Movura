import 'package:dio/dio.dart';
import 'package:movura/features/details_screen/data/models/about_model.dart';
import 'package:movura/features/details_screen/data/models/review_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/utils/constants/api_constants.dart';

part 'details_web_services.g.dart';

@RestApi()
abstract class DetailsWebServices {
  factory DetailsWebServices(Dio dio, {String? baseUrl}) = _DetailsWebServices;

  @GET("${ApiConstants.movieDetails}/{id}")
  Future<AboutModel> getMovieMainDetails({
    @Path("id") required int movieId,
    @Query("append_to_response")
    String additionalData = "credits,images,videos",
    @Query("language") String language = "en-US",
  });

  @GET("${ApiConstants.movieDetails}/{id}/reviews")
  Future<ReviewsResponse> getMovieReviews({
    @Path("id") required int movieId,
    @Query("language") String language = "en-US",
  });
}
