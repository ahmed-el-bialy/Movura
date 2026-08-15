import 'package:json_annotation/json_annotation.dart';

import 'about_tv_series_model.dart';

part 'season_details_model.g.dart';

@JsonSerializable()
class SeasonDetailsModel {
  @JsonKey(name: "_id")
  final String? stringId;
  final int id;
  @JsonKey(name: "air_date")
  final String? airDate;
  final String? name;
  final String? overview;
  @JsonKey(name: "poster_path")
  final String? posterPath;
  @JsonKey(name: "season_number")
  final int seasonNumber;
  final List<EpisodeModel> episodes;

  @JsonKey(name: "credits")
  final TvActorResponse? credits;

  @JsonKey(name: "videos")
  final TvVideoResponse? videos;

  @JsonKey(name: "images")
  final TvImagesResponse? images;

  SeasonDetailsModel({
    this.stringId,
    required this.id,
    this.airDate,
    this.name,
    this.overview,
    this.posterPath,
    required this.seasonNumber,
    required this.episodes,
    this.credits,
    this.videos,
    this.images,
  });

  factory SeasonDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$SeasonDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonDetailsModelToJson(this);
}

@JsonSerializable()
class EpisodeModel {
  final int id;
  final String? name;
  final String? overview;
  @JsonKey(name: "air_date")
  final String? airDate;
  @JsonKey(name: "episode_number")
  final int episodeNumber;
  @JsonKey(name: "season_number")
  final int seasonNumber;
  @JsonKey(name: "still_path")
  final String? stillPath;
  @JsonKey(name: "vote_average")
  final double? voteAverage;
  final int? runtime;

  EpisodeModel({
    required this.id,
    this.name,
    this.overview,
    this.airDate,
    required this.episodeNumber,
    required this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.runtime,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeModelToJson(this);
}
