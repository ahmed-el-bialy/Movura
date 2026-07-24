import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/models/actor_model.dart';
import '../../../../../core/models/company_model.dart';
import '../../../../../core/models/genre_model.dart';
import '../../../../../core/models/image_model.dart';
import '../../../../../core/models/video_model.dart';

import 'package:movura/core/models/watch_provider_model.dart';

part 'about_model.g.dart';

@JsonSerializable()
class AboutModel {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "original_language")
  final String language;

  @JsonKey(name: "poster_path")
  final String? posterPath;

  @JsonKey(name: "title")
  final String title;

  @JsonKey(name: "overview")
  final String overview;

  final double runtime;

  @JsonKey(name: "vote_average")
  final double rating;

  @JsonKey(name: "genres")
  final List<GenreModel> genres;

  @JsonKey(name: "credits")
  final ActorResponse actors;

  @JsonKey(name: "production_companies")
  final List<CompanyModel> companies;

  @JsonKey(name: "budget")
  final int budget;

  @JsonKey(name: "revenue")
  final int revenue;

  final String? homepage;

  @JsonKey(name: "adult")
  final bool adultContent;

  @JsonKey(name: "images")
  final ImagesResponse mediaImages;

  @JsonKey(name: "videos")
  final VideoResponse? movieVideos;

  @JsonKey(name: "watch/providers")
  final WatchProviderResponse? watchProviders;

  AboutModel({
    required this.id,
    required this.language,
    required this.posterPath,
    required this.title,
    required this.overview,
    required this.runtime,
    required this.rating,
    required this.genres,
    required this.actors,
    required this.companies,
    required this.budget,
    required this.revenue,
    this.homepage,
    required this.adultContent,
    required this.mediaImages,
    this.movieVideos,
    this.watchProviders,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) =>
      _$AboutModelFromJson(json);

  Map<String, dynamic> toJson() => _$AboutModelToJson(this);
}

@JsonSerializable()
class VideoResponse {
  @JsonKey(name: "results")
  final List<VideoModel>? videoList;

  VideoResponse({this.videoList});

  factory VideoResponse.fromJson(Map<String, dynamic> json) =>
      _$VideoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VideoResponseToJson(this);
}

@JsonSerializable()
class ImagesResponse {
  @JsonKey(name: "backdrops")
  final List<ImageModel>? backdropImages;

  @JsonKey(name: "logos")
  final List<ImageModel>? logoImages;

  ImagesResponse({this.backdropImages, this.logoImages});

  factory ImagesResponse.fromJson(Map<String, dynamic> json) =>
      _$ImagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesResponseToJson(this);
}

@JsonSerializable()
class ActorResponse {
  @JsonKey(name: "cast")
  final List<ActorModel>? movieActors;

  ActorResponse({this.movieActors});

  factory ActorResponse.fromJson(Map<String, dynamic> json) =>
      _$ActorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActorResponseToJson(this);
}
