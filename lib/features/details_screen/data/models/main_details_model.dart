import 'package:json_annotation/json_annotation.dart';

part 'main_details_model.g.dart';

@JsonSerializable()
class MainDetailsModel {
  @JsonKey(name: "adult")
  final bool isForAdults;
  @JsonKey(name: "original_language")
  final String language;
  @JsonKey(name: "poster_path")
  final String posterPath;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "overview")
  final String overview;
  final double runtime;
  @JsonKey(name: "vote_average")
  final double rating;
  @JsonKey(name: "genres")
  final List<Genre> genres;

  MainDetailsModel({
    required this.isForAdults,
    required this.language,
    required this.posterPath,
    required this.title,
    required this.overview,
    required this.runtime,
    required this.rating,
    required this.genres,
  });

  factory MainDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MainDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainDetailsModelToJson(this);
}

@JsonSerializable()
class GenresList {
  @JsonKey(name: "genres")
  final List<Genre> genres;

  GenresList({required this.genres});

  factory GenresList.fromJson(Map<String, dynamic> json) =>
      _$GenresListFromJson(json);

  Map<String, dynamic> toJson() => _$GenresListToJson(this);
}

@JsonSerializable()
@JsonSerializable()
class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
  Map<String, dynamic> toJson() => _$GenreToJson(this);
}