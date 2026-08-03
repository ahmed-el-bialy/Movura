// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'person_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonDetailsModel _$PersonDetailsModelFromJson(Map<String, dynamic> json) =>
    PersonDetailsModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      biography: json['biography'] as String?,
      birthday: json['birthday'] as String?,
      placeOfBirth: json['place_of_birth'] as String?,
      profilePath: json['profile_path'] as String?,
      knownFor: json['known_for_department'] as String?,
      movieCredits: json['movie_credits'] == null
          ? null
          : PersonMovieCredits.fromJson(
              json['movie_credits'] as Map<String, dynamic>,
            ),
      tvCredits: json['tv_credits'] == null
          ? null
          : PersonTvCredits.fromJson(
              json['tv_credits'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$PersonDetailsModelToJson(PersonDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'biography': instance.biography,
      'birthday': instance.birthday,
      'place_of_birth': instance.placeOfBirth,
      'profile_path': instance.profilePath,
      'known_for_department': instance.knownFor,
      'movie_credits': instance.movieCredits,
      'tv_credits': instance.tvCredits,
    };

PersonMovieCredits _$PersonMovieCreditsFromJson(Map<String, dynamic> json) =>
    PersonMovieCredits(
      cast: (json['cast'] as List<dynamic>?)
          ?.map((e) => PersonCastMovie.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PersonMovieCreditsToJson(PersonMovieCredits instance) =>
    <String, dynamic>{'cast': instance.cast};

PersonCastMovie _$PersonCastMovieFromJson(Map<String, dynamic> json) =>
    PersonCastMovie(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      character: json['character'] as String?,
    );

Map<String, dynamic> _$PersonCastMovieToJson(PersonCastMovie instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'character': instance.character,
    };

PersonTvCredits _$PersonTvCreditsFromJson(Map<String, dynamic> json) =>
    PersonTvCredits(
      cast: (json['cast'] as List<dynamic>?)
          ?.map((e) => PersonCastTv.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PersonTvCreditsToJson(PersonTvCredits instance) =>
    <String, dynamic>{'cast': instance.cast};

PersonCastTv _$PersonCastTvFromJson(Map<String, dynamic> json) => PersonCastTv(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  posterPath: json['poster_path'] as String?,
  firstAirDate: json['first_air_date'] as String?,
  character: json['character'] as String?,
);

Map<String, dynamic> _$PersonCastTvToJson(PersonCastTv instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'poster_path': instance.posterPath,
      'first_air_date': instance.firstAirDate,
      'character': instance.character,
    };
