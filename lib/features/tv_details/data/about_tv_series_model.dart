import 'package:json_annotation/json_annotation.dart';

import '../../../core/models/actor_model.dart';
import '../../../core/models/company_model.dart';
import '../../../core/models/genre_model.dart';
import '../../../core/models/image_model.dart';
import '../../../core/models/video_model.dart';
import '../../../core/models/watch_provider_model.dart';

part 'about_tv_series_model.g.dart';

@JsonSerializable()
class AboutTvSeriesModel {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "original_language")
  final String? language;

  @JsonKey(name: "poster_path")
  final String? posterPath;

  @JsonKey(name: "backdrop_path")
  final String? backdropPath;

  @JsonKey(name: "name")
  final String? title;

  @JsonKey(name: "original_name")
  final String? originalTitle;

  @JsonKey(name: "overview")
  final String? overview;

  @JsonKey(name: "vote_average")
  final double? rating;

  @JsonKey(name: "first_air_date")
  final String? startAirDate;

  @JsonKey(name: "last_air_date")
  final String? endAirDate;

  @JsonKey(name: "status")
  final String? status;

  @JsonKey(name: "tagline")
  final String? tagline;

  @JsonKey(name: "type")
  final String? type;

  @JsonKey(name: "in_production")
  final bool? inProduction;

  @JsonKey(name: "number_of_seasons")
  final int? numberOfSeasons;

  @JsonKey(name: "number_of_episodes")
  final int? numberOfEpisodes;

  @JsonKey(name: "episode_run_time")
  final List<int>? episodeRunTime;

  @JsonKey(name: "genres")
  final List<GenreModel>? genres;

  @JsonKey(name: "networks")
  final List<TvNetworkModel>? networks;

  @JsonKey(name: "production_companies")
  final List<CompanyModel>? companies;

  @JsonKey(name: "seasons")
  final List<TvSeasonModel>? seasons;

  @JsonKey(name: "credits")
  final TvActorResponse? actors;

  final String? homepage;

  @JsonKey(name: "adult")
  final bool? adultContent;

  @JsonKey(name: "images")
  final TvImagesResponse? mediaImages;

  @JsonKey(name: "videos")
  final TvVideoResponse? tvVideos;

  @JsonKey(name: "watch/providers")
  final WatchProviderResponse? watchProviders;

  AboutTvSeriesModel({
    required this.id,
    this.language,
    this.posterPath,
    this.backdropPath,
    this.title,
    this.originalTitle,
    this.overview,
    this.rating,
    this.status,
    this.tagline,
    this.type,
    this.inProduction,
    this.numberOfSeasons,
    this.numberOfEpisodes,
    this.episodeRunTime,
    this.genres,
    this.networks,
    this.companies,
    this.seasons,
    this.actors,
    this.homepage,
    this.adultContent,
    this.mediaImages,
    this.tvVideos,
    this.startAirDate,
    this.endAirDate,
    this.watchProviders,
  });

  factory AboutTvSeriesModel.fromJson(Map<String, dynamic> json) =>
      _$AboutTvSeriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$AboutTvSeriesModelToJson(this);
}

@JsonSerializable()
class TvSeasonModel {
  final int id;
  final String? name;
  @JsonKey(name: "season_number")
  final int seasonNumber;
  @JsonKey(name: "episode_count")
  final int? episodeCount;
  @JsonKey(name: "poster_path")
  final String? posterPath;
  @JsonKey(name: "vote_average")
  final double? voteAverage;
  @JsonKey(name: "air_date")
  final String? airDate;

  TvSeasonModel({
    required this.id,
    this.name,
    required this.seasonNumber,
    this.episodeCount,
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
  final String? name;
  @JsonKey(name: "logo_path")
  final String? logo;
  @JsonKey(name: "origin_country")
  final String? originCountry;

  TvNetworkModel({required this.id, this.name, this.logo, this.originCountry});

  factory TvNetworkModel.fromJson(Map<String, dynamic> json) =>
      _$TvNetworkModelFromJson(json);

  Map<String, dynamic> toJson() => _$TvNetworkModelToJson(this);
}

@JsonSerializable()
class TvActorResponse {
  @JsonKey(name: "cast")
  final List<ActorModel>? tvActors;

  TvActorResponse({this.tvActors});

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
