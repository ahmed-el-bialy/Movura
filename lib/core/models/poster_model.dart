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

  @JsonKey(name: "known_for_department")
  final String? knownForDepartment;

  @JsonKey(name: "profile_path")
  final String? profilePath;

  @JsonKey(name: "genre_ids")
  final List<int>? genreIds;

  @JsonKey(name: "popularity")
  final double? popularity;

  @JsonKey(name: "release_date")
  final String? releaseDate;

  @JsonKey(name: "first_air_date")
  final String? firstAirDate;

  PosterModel({
    required this.id,
    this.title,
    this.name,
    this.posterPath,
    this.mediaType,
    this.voteAverage,
    this.knownForDepartment,
    this.profilePath,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.firstAirDate,
  });

  factory PosterModel.fromJson(Map<String, dynamic> json) {
    return PosterModel(
      id: (json['id'] is num)
          ? (json['id'] as num).toInt()
          : (int.tryParse(json['id']?.toString() ?? '0') ?? 0),
      title: json['title']?.toString(),
      name: json['name']?.toString(),
      posterPath: json['poster_path']?.toString(),
      mediaType: json['media_type']?.toString(),
      voteAverage: (json['vote_average'] is num)
          ? (json['vote_average'] as num).toDouble()
          : (double.tryParse(json['vote_average']?.toString() ?? '')),
      knownForDepartment: json['known_for_department']?.toString(),
      profilePath: json['profile_path']?.toString(),
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => e is num ? e.toInt() : (int.tryParse(e.toString()) ?? 0))
          .toList(),
      popularity: (json['popularity'] is num)
          ? (json['popularity'] as num).toDouble()
          : (double.tryParse(json['popularity']?.toString() ?? '')),
      releaseDate: json['release_date']?.toString(),
      firstAirDate: json['first_air_date']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => _$PosterModelToJson(this);

  PosterModel copyWith({
    int? id,
    String? title,
    String? name,
    String? posterPath,
    String? mediaType,
    double? voteAverage,
    String? knownForDepartment,
    String? profilePath,
    List<int>? genreIds,
    double? popularity,
    String? releaseDate,
    String? firstAirDate,
  }) {
    return PosterModel(
      id: id ?? this.id,
      title: title ?? this.title,
      name: name ?? this.name,
      posterPath: posterPath ?? this.posterPath,
      mediaType: mediaType ?? this.mediaType,
      voteAverage: voteAverage ?? this.voteAverage,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      profilePath: profilePath ?? this.profilePath,
      genreIds: genreIds ?? this.genreIds,
      popularity: popularity ?? this.popularity,
      releaseDate: releaseDate ?? this.releaseDate,
      firstAirDate: firstAirDate ?? this.firstAirDate,
    );
  }
}
