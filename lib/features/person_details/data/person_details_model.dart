import 'package:json_annotation/json_annotation.dart';

part 'person_details_model.g.dart';

@JsonSerializable()
class PersonDetailsModel {
  final int id;
  final String? name;
  final String? biography;
  @JsonKey(name: "birthday")
  final String? birthday;
  @JsonKey(name: "place_of_birth")
  final String? placeOfBirth;
  @JsonKey(name: "profile_path")
  final String? profilePath;
  @JsonKey(name: "known_for_department")
  final String? knownFor;
  @JsonKey(name: "movie_credits")
  final PersonMovieCredits? movieCredits;
  @JsonKey(name: "tv_credits")
  final PersonTvCredits? tvCredits;

  PersonDetailsModel({
    required this.id,
    this.name,
    this.biography,
    this.birthday,
    this.placeOfBirth,
    this.profilePath,
    this.knownFor,
    this.movieCredits,
    this.tvCredits,
  });

  factory PersonDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PersonDetailsModelFromJson(json);
}

@JsonSerializable()
class PersonMovieCredits {
  final List<PersonCastMovie>? cast;

  PersonMovieCredits({this.cast});

  factory PersonMovieCredits.fromJson(Map<String, dynamic> json) =>
      _$PersonMovieCreditsFromJson(json);
}

@JsonSerializable()
class PersonCastMovie {
  final int id;
  final String? title;
  @JsonKey(name: "poster_path")
  final String? posterPath;
  @JsonKey(name: "release_date")
  final String? releaseDate;
  final String? character;

  PersonCastMovie({
    required this.id,
    this.title,
    this.posterPath,
    this.releaseDate,
    this.character,
  });

  factory PersonCastMovie.fromJson(Map<String, dynamic> json) =>
      _$PersonCastMovieFromJson(json);
}

@JsonSerializable()
class PersonTvCredits {
  final List<PersonCastTv>? cast;

  PersonTvCredits({this.cast});

  factory PersonTvCredits.fromJson(Map<String, dynamic> json) =>
      _$PersonTvCreditsFromJson(json);
}

@JsonSerializable()
class PersonCastTv {
  final int id;
  final String? name;
  @JsonKey(name: "poster_path")
  final String? posterPath;
  @JsonKey(name: "first_air_date")
  final String? firstAirDate;
  final String? character;

  PersonCastTv({
    required this.id,
    this.name,
    this.posterPath,
    this.firstAirDate,
    this.character,
  });

  factory PersonCastTv.fromJson(Map<String, dynamic> json) =>
      _$PersonCastTvFromJson(json);
}
