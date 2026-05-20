// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainDetailsModel _$MainDetailsModelFromJson(Map<String, dynamic> json) =>
    MainDetailsModel(
      isForAdults: json['adult'] as bool,
      language: json['original_language'] as String,
      posterPath: json['poster_path'] as String,
      title: json['title'] as String,
      overview: json['overview'] as String,
      runtime: (json['runtime'] as num).toDouble(),
      rating: (json['vote_average'] as num).toDouble(),
      genres: (json['genres'] as List<dynamic>)
          .map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MainDetailsModelToJson(MainDetailsModel instance) =>
    <String, dynamic>{
      'adult': instance.isForAdults,
      'original_language': instance.language,
      'poster_path': instance.posterPath,
      'title': instance.title,
      'overview': instance.overview,
      'runtime': instance.runtime,
      'vote_average': instance.rating,
      'genres': instance.genres,
    };

GenresList _$GenresListFromJson(Map<String, dynamic> json) => GenresList(
  genres: (json['genres'] as List<dynamic>)
      .map((e) => Genre.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GenresListToJson(GenresList instance) =>
    <String, dynamic>{'genres': instance.genres};

Genre _$GenreFromJson(Map<String, dynamic> json) =>
    Genre(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};
