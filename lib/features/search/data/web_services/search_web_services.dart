
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/models/poster_model.dart';

part 'search_web_services.g.dart';

@RestApi()
abstract class SearchWebServices {
  factory SearchWebServices(Dio dio, {String? baseUrl}) = _SearchWebServices;

  @GET(ApiConstants.multiSearch)
  Future<PosterResponse> getMultiSearchResults({
    @Query("language") String language = "en-US",
    @Query("query") required String query,
    @Query("page") int? page=1,
  });

  @GET(ApiConstants.movieSearch)
  Future<PosterResponse> getMovieSearchResults({
    @Query("language") String language = "en-US",
    @Query("query") required String query,
    @Query("page") int? page=1,
  });

  @GET(ApiConstants.tvSearch)
  Future<PosterResponse> getTvSearchResults({
    @Query("language") String language = "en-US",
    @Query("query") required String query,
    @Query("page") int? page=1,
  });

  @GET(ApiConstants.personSearch)
  Future<PosterResponse> getPersonSearchResults({
    @Query("language") String language = "en-US",
    @Query("query") required String query,
    @Query("page") int? page=1,
  });
}