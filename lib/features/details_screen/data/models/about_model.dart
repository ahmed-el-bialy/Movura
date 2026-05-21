import 'package:json_annotation/json_annotation.dart';

part 'about_model.g.dart';

@JsonSerializable()
class AboutModel {
  @JsonKey(name: "id")
  final int id;

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

  @JsonKey(name: "credits")
  final ActorResponse actors;

  @JsonKey(name: "production_companies")
  final List<CompanyModel> companies;

  @JsonKey(name: "budget")
  final int budget;

  @JsonKey(name: "revenue")
  final int revenue;

  @JsonKey(name: "adult")
  final bool adultContent;

  @JsonKey(name: "images")
  final ImagesResponse mediaImages;

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
    required this.adultContent,
    required this.mediaImages,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) =>
      _$AboutModelFromJson(json);

  Map<String, dynamic> toJson() => _$AboutModelToJson(this);
}

@JsonSerializable()
class ImagesResponse {
  @JsonKey(name: "backdrops")
  final List<ImageModel> backdropImages;

  @JsonKey(name: "logos")
  final List<ImageModel> logoImages;

  ImagesResponse({required this.backdropImages, required this.logoImages});

  factory ImagesResponse.fromJson(Map<String, dynamic> json) =>
      _$ImagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesResponseToJson(this);
}

@JsonSerializable()
class ImageModel {
  @JsonKey(name: "file_path")
  final String? imagePath;

  ImageModel({this.imagePath});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}

@JsonSerializable()
class ActorResponse {
  @JsonKey(name: "cast")
  final List<ActorModel> movieActors;

  ActorResponse({required this.movieActors});

  factory ActorResponse.fromJson(Map<String, dynamic> json) =>
      _$ActorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActorResponseToJson(this);
}

@JsonSerializable()
class ActorModel {
  @JsonKey(name: "known_for_department")
  final String job;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "character")
  final String character;
  @JsonKey(name: "profile_path")
  final String? actorImage;

  ActorModel({
    required this.job,
    required this.name,
    required this.character,
    this.actorImage,
  });

  factory ActorModel.fromJson(Map<String, dynamic> json) =>
      _$ActorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActorModelToJson(this);
}

@JsonSerializable()
class CompanyModel {
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "origin_country")
  final String originCountry;
  @JsonKey(name: "logo_path")
  final String? logo;

  CompanyModel({required this.name, required this.originCountry, this.logo});

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}

@JsonSerializable()
class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}
