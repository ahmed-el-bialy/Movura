import 'package:json_annotation/json_annotation.dart';
import 'package:movura/core/models/actor_model.dart';
import 'package:movura/core/models/company_model.dart';
import 'package:movura/core/models/genre_model.dart';
import 'package:movura/core/models/image_model.dart';
import 'package:movura/core/models/video_model.dart';

part 'about_tv_series_model.g.dart';

@JsonSerializable()
class AboutTvSeriesModel {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "original_language")
  final String language;

  @JsonKey(name: "poster_path")
  final String? posterPath;

  @JsonKey(name: "backdrop_path")
  final String? backdropPath;

  @JsonKey(name: "name")
  final String title;

  @JsonKey(name: "overview")
  final String overview;

  @JsonKey(name: "vote_average")
  final double rating;

  @JsonKey(name: "first_air_date")
  final String startAirDate;

  @JsonKey(name: "last_air_date")
  final String? endAirDate;

  @JsonKey(name: "status")
  final String status;

  @JsonKey(name: "tagline")
  final String? tagline;

  @JsonKey(name: "type")
  final String type;

  @JsonKey(name: "in_production")
  final bool inProduction;

  @JsonKey(name: "number_of_seasons")
  final int numberOfSeasons;

  @JsonKey(name: "number_of_episodes")
  final int numberOfEpisodes;

  @JsonKey(name: "episode_run_time")
  final List<int> episodeRunTime;

  @JsonKey(name: "genres")
  final List<GenreModel> genres;

  @JsonKey(name: "networks")
  final List<TvNetworkModel> networks;

  @JsonKey(name: "production_companies")
  final List<CompanyModel> companies;

  @JsonKey(name: "seasons")
  final List<TvSeasonModel> seasons;

  @JsonKey(name: "credits")
  final TvActorResponse actors;

  @JsonKey(name: "adult")
  final bool adultContent;

  @JsonKey(name: "images")
  final TvImagesResponse mediaImages;

  @JsonKey(name: "videos")
  final TvVideoResponse? tvVideos;

  AboutTvSeriesModel({
    required this.id,
    required this.language,
    this.posterPath,
    this.backdropPath,
    required this.title,
    required this.overview,
    required this.rating,
    required this.status,
    this.tagline,
    required this.type,
    required this.inProduction,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
    required this.episodeRunTime,
    required this.genres,
    required this.networks,
    required this.companies,
    required this.seasons,
    required this.actors,
    required this.adultContent,
    required this.mediaImages,
    this.tvVideos,
    required this.startAirDate,
    this.endAirDate,
  });

  factory AboutTvSeriesModel.fromJson(Map<String, dynamic> json) =>
      _$AboutTvSeriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$AboutTvSeriesModelToJson(this);
}

@JsonSerializable()
class TvSeasonModel {
  final int id;
  final String name;
  @JsonKey(name: "season_number")
  final int seasonNumber;
  @JsonKey(name: "episode_count")
  final int episodeCount;
  @JsonKey(name: "poster_path")
  final String? posterPath;
  @JsonKey(name: "vote_average")
  final double? voteAverage;
  @JsonKey(name: "air_date")
  final String? airDate;

  TvSeasonModel({
    required this.id,
    required this.name,
    required this.seasonNumber,
    required this.episodeCount,
    this.posterPath,
    this.voteAverage,
    this.airDate,
  });

  factory TvSeasonModel.fromJson(Map<String, dynamic> json) =>
      _$TvSeasonModelFromJson(json);

  Map<String, dynamic> toJson() => _$TvSeasonModelToJson(this);
}

@JsonSerializable()
class TvNetworkModel {
  final int id;
  final String name;
  @JsonKey(name: "logo_path")
  final String? logo;
  @JsonKey(name: "origin_country")
  final String originCountry;

  TvNetworkModel({
    required this.id,
    required this.name,
    this.logo,
    required this.originCountry,
  });

  factory TvNetworkModel.fromJson(Map<String, dynamic> json) =>
      _$TvNetworkModelFromJson(json);

  Map<String, dynamic> toJson() => _$TvNetworkModelToJson(this);
}

@JsonSerializable()
class TvActorResponse {
  @JsonKey(name: "cast")
  final List<ActorModel> tvActors;

  TvActorResponse({required this.tvActors});

  factory TvActorResponse.fromJson(Map<String, dynamic> json) =>
      _$TvActorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TvActorResponseToJson(this);
}

@JsonSerializable()
class TvVideoResponse {
  @JsonKey(name: "results")
  final List<VideoModel>? videoList;

  TvVideoResponse({this.videoList});

  factory TvVideoResponse.fromJson(Map<String, dynamic> json) =>
      _$TvVideoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TvVideoResponseToJson(this);
}

@JsonSerializable()
class TvImagesResponse {
  @JsonKey(name: "backdrops")
  final List<ImageModel>? backdropImages;
  @JsonKey(name: "logos")
  final List<ImageModel>? logoImages;
  @JsonKey(name: "stills")
  final List<ImageModel>? stills;

  TvImagesResponse({this.backdropImages, this.logoImages, this.stills});

  factory TvImagesResponse.fromJson(Map<String, dynamic> json) =>
      _$TvImagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TvImagesResponseToJson(this);
}
