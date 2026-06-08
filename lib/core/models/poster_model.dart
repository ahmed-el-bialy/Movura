import 'package:json_annotation/json_annotation.dart';

part 'poster_model.g.dart';

@JsonSerializable()
class PosterResponse {
  @JsonKey(name: "results")
  final List<PosterModel>? results;

  PosterResponse({this.results});

  factory PosterResponse.fromJson(Map<String, dynamic> json) =>
      _$PosterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PosterResponseToJson(this);
}

@JsonSerializable()
class PosterModel {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "poster_path")
  final String? posterPath;
  @JsonKey(name: "media_type")
  final String? mediaType;

  @JsonKey(name: "vote_average")
  final double? voteAverage;

  PosterModel({
    required this.id,
    this.title,
    this.name,
    this.posterPath,
    this.mediaType,
    this.voteAverage,
  });

  factory PosterModel.fromJson(Map<String, dynamic> json) =>
      _$PosterModelFromJson(json);

  Map<String, dynamic> toJson() => _$PosterModelToJson(this);
}
