import 'package:json_annotation/json_annotation.dart';

import '../../../core/models/actor_model.dart';
import 'about_tv_series_model.dart';

part 'episode_details_model.g.dart';

@JsonSerializable()
class EpisodeDetailsModel {
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

  @JsonKey(name: "guest_stars")
  final List<ActorModel>? guestStars;

  @JsonKey(name: "crew")
  final List<ActorModel>? crew;

  @JsonKey(name: "images")
  final TvImagesResponse? images;

  @JsonKey(name: "videos")
  final TvVideoResponse? videos;

  EpisodeDetailsModel({
    required this.id,
    this.name,
    this.overview,
    this.airDate,
    required this.episodeNumber,
    required this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.runtime,
    this.guestStars,
    this.crew,
    this.images,
    this.videos,
  });

  factory EpisodeDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeDetailsModelToJson(this);
}
