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
  title: json['title'] as String,
  posterPath: json['poster_path'] as String,
  voteAverage: json['vote_average'] as String,
  mediaType: json['media_type'] as String,
  id: (json['id'] as num).toInt(),
);

Map<String, dynamic> _$PosterModelToJson(PosterModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'media_type': instance.mediaType,
      'id': instance.id,
    };
