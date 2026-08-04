// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poster_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PosterResponse _$PosterResponseFromJson(Map<String, dynamic> json) =>
    PosterResponse(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => PosterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PosterResponseToJson(PosterResponse instance) =>
    <String, dynamic>{'results': instance.results};

PosterModel _$PosterModelFromJson(Map<String, dynamic> json) => PosterModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String?,
  name: json['name'] as String?,
  posterPath: json['poster_path'] as String?,
  mediaType: json['media_type'] as String?,
  voteAverage: (json['vote_average'] as num?)?.toDouble(),
  knownForDepartment: json['known_for_department'] as String?,
  profilePath: json['profile_path'] as String?,
  genreIds: (json['genre_ids'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  popularity: (json['popularity'] as num?)?.toDouble(),
  releaseDate: json['release_date'] as String?,
  firstAirDate: json['first_air_date'] as String?,
);

Map<String, dynamic> _$PosterModelToJson(PosterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'name': instance.name,
      'poster_path': instance.posterPath,
      'media_type': instance.mediaType,
      'vote_average': instance.voteAverage,
      'known_for_department': instance.knownForDepartment,
      'profile_path': instance.profilePath,
      'genre_ids': instance.genreIds,
      'popularity': instance.popularity,
      'release_date': instance.releaseDate,
      'first_air_date': instance.firstAirDate,
    };
