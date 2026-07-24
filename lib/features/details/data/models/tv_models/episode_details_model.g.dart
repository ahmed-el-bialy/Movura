// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeDetailsModel _$EpisodeDetailsModelFromJson(Map<String, dynamic> json) =>
    EpisodeDetailsModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      overview: json['overview'] as String?,
      airDate: json['air_date'] as String?,
      episodeNumber: (json['episode_number'] as num).toInt(),
      seasonNumber: (json['season_number'] as num).toInt(),
      stillPath: json['still_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      runtime: (json['runtime'] as num?)?.toInt(),
      guestStars: (json['guest_stars'] as List<dynamic>?)
          ?.map((e) => ActorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>?)
          ?.map((e) => ActorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EpisodeDetailsModelToJson(
  EpisodeDetailsModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'overview': instance.overview,
  'air_date': instance.airDate,
  'episode_number': instance.episodeNumber,
  'season_number': instance.seasonNumber,
  'still_path': instance.stillPath,
  'vote_average': instance.voteAverage,
  'runtime': instance.runtime,
  'guest_stars': instance.guestStars,
  'crew': instance.crew,
};
