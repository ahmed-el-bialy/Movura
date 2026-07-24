import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movura/core/models/genre_model.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:retrofit/retrofit.dart';

part 'home_web_services.g.dart';

@RestApi()
abstract class HomeWebServices {
  factory HomeWebServices(Dio dio, {String? baseUrl}) = _HomeWebServices;

  @GET(ApiConstants.trendingMedia)
  Future<PosterResponse> getTrendingMedia({
    @Query("language") String language = "en-US",
  });

  @GET(ApiConstants.topRatedMovies)
  Future<PosterResponse> getTopRatedMovies({
    @Query("language") String language = "en-US",
  });

  @GET(ApiConstants.topRatedTvSeries)
  Future<PosterResponse> getTopRatedTvSeries({
    @Query("language") String language = "en-US",
  });

  @GET(ApiConstants.movieGenres)
  Future<GenreResponse> getMovieGenres({
    @Query("language") String language = "en-US",
  });

  @GET(ApiConstants.tvGenres)
  Future<GenreResponse> getTvGenres({
    @Query("language") String language = "en-US",
  });
}

@JsonSerializable()
class GenreResponse {
  final List<GenreModel> genres;

  GenreResponse({required this.genres});

  factory GenreResponse.fromJson(Map<String, dynamic> json) =>
      _$GenreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenreResponseToJson(this);
}
