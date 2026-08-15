import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/models/review_model.dart';
import '../../../../core/models/similar_model.dart';
import '../../../../core/models/poster_model.dart';
import '../about_tv_series_model.dart';
import '../episode_details_model.dart';
import '../season_details_model.dart';

part 'tv_web_services.g.dart';

@RestApi()
abstract class TvWebServices {
  factory TvWebServices(Dio dio, {String? baseUrl}) = _TvWebServices;

  @GET("${ApiConstants.tvDetails}/{id}")
  Future<AboutTvSeriesModel> getTvSeriesMainDetails({
    @Path("id") required int id,
    @Query("append_to_response")
    String additionalData = "credits,images,videos,watch/providers",
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

  @GET("${ApiConstants.tvDetails}/{id}/similar")
  Future<PosterResponse> getSimilarTvSeriesPaginated({
    @Path("id") required int id,
    @Query("page") required int page,
    @Query("language") String language = "en-US",
  });


  @GET("${ApiConstants.tvDetails}/{id}/season/{season_number}")
  Future<SeasonDetailsModel> getTvSeasonDetails({
    @Path("id") required int id,
    @Path("season_number") required int seasonNumber,
    @Query("append_to_response")
    String additionalData = "credits,images,videos",
    @Query("language") String language = "en-US",
  });

  @GET(
    "${ApiConstants.tvDetails}/{id}/season/{season_number}/episode/{episode_number}",
  )
  Future<EpisodeDetailsModel> getTvEpisodeDetails({
    @Path("id") required int id,
    @Path("season_number") required int seasonNumber,
    @Path("episode_number") required int episodeNumber,
    @Query("append_to_response")
    String additionalData = "credits,images,videos",
    @Query("language") String language = "en-US",
  });
}
