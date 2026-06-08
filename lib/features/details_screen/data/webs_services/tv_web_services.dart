import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/utils/constants/api_constants.dart';
import '../models/shared_models/review_model.dart';
import '../models/shared_models/similar_model.dart';
import '../models/tv_models/about_tv_series_model.dart';

part 'tv_web_services.g.dart';

@RestApi()
abstract class TvWebServices {
  factory TvWebServices(Dio dio, {String? baseUrl}) = _TvWebServices;

  @GET("${ApiConstants.tvDetails}/{id}")
  Future<AboutTvSeriesModel> getTvSeriesMainDetails({
    @Path("id") required int id,
    @Query("append_to_response")
    String additionalData = "credits,images,videos",
    @Query("language") String language = "en-US",
  });

  @GET("${ApiConstants.tvDetails}/{id}/reviews")
  Future<ReviewsResponse> getTvSeriesReviews({
    @Path("id") required int id,
    @Query("language") String language = "en-US",
  });

  @GET("${ApiConstants.tvDetails}/{id}")
  Future<SimilarContentResponse> getSimilarTvSeries({
    @Path("id") required int id,
    @Query("append_to_response")
    String additionalData = "similar,recommendations",
    @Query("language") String language = "en-US",
  });
}
