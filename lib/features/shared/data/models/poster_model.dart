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
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "poster_path")
  final String posterPath;
  @JsonKey(name: "vote_average")
  final double voteAverage;
  @JsonKey(name: "media_type")
  final String mediaType;
  @JsonKey(name: "id")
  final int id;

  PosterModel({
    this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.mediaType,
    required this.id,
    this.name,
  });

  factory PosterModel.fromJson(Map<String, dynamic> json) =>
      _$PosterModelFromJson(json);

  Map<String, dynamic> toJson() => _$PosterModelToJson(this);
}
