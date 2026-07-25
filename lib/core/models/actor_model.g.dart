// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorModel _$ActorModelFromJson(Map<String, dynamic> json) => ActorModel(
  id: (json['id'] as num?)?.toInt(),
  job: json['known_for_department'] as String?,
  name: json['name'] as String?,
  character: json['character'] as String?,
  actorImage: json['profile_path'] as String?,
);

Map<String, dynamic> _$ActorModelToJson(ActorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'known_for_department': instance.job,
      'name': instance.name,
      'character': instance.character,
      'profile_path': instance.actorImage,
    };
