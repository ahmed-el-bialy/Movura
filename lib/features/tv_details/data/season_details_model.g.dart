// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeasonDetailsModel _$SeasonDetailsModelFromJson(Map<String, dynamic> json) =>
    SeasonDetailsModel(
      stringId: json['_id'] as String?,
      id: (json['id'] as num).toInt(),
      airDate: json['air_date'] as String?,
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      seasonNumber: (json['season_number'] as num).toInt(),
      episodes: (json['episodes'] as List<dynamic>)
          .map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      credits: json['credits'] == null
          ? null
          : TvActorResponse.fromJson(json['credits'] as Map<String, dynamic>),
      videos: json['videos'] == null
          ? null
          : TvVideoResponse.fromJson(json['videos'] as Map<String, dynamic>),
      images: json['images'] == null
          ? null
          : TvImagesResponse.fromJson(json['images'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeasonDetailsModelToJson(SeasonDetailsModel instance) =>
    <String, dynamic>{
      '_id': instance.stringId,
      'id': instance.id,
      'air_date': instance.airDate,
      'name': instance.name,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'season_number': instance.seasonNumber,
      'episodes': instance.episodes,
      'credits': instance.credits,
      'videos': instance.videos,
      'images': instance.images,
    };

EpisodeModel _$EpisodeModelFromJson(Map<String, dynamic> json) => EpisodeModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  overview: json['overview'] as String?,
  airDate: json['air_date'] as String?,
  episodeNumber: (json['episode_number'] as num).toInt(),
  seasonNumber: (json['season_number'] as num).toInt(),
  stillPath: json['still_path'] as String?,
  voteAverage: (json['vote_average'] as num?)?.toDouble(),
  runtime: (json['runtime'] as num?)?.toInt(),
);

Map<String, dynamic> _$EpisodeModelToJson(EpisodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'air_date': instance.airDate,
      'episode_number': instance.episodeNumber,
      'season_number': instance.seasonNumber,
      'still_path': instance.stillPath,
      'vote_average': instance.voteAverage,
      'runtime': instance.runtime,
    };
