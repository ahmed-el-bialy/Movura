// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  favorites: (json['favorites'] as List<dynamic>?)
      ?.map((e) => PosterModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  watched: (json['watched'] as List<dynamic>?)
      ?.map((e) => PosterModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  toWatch: (json['toWatch'] as List<dynamic>?)
      ?.map((e) => PosterModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  watchNow: (json['watchNow'] as List<dynamic>?)
      ?.map((e) => PosterModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
  'favorites': instance.favorites,
  'watched': instance.watched,
  'toWatch': instance.toWatch,
  'watchNow': instance.watchNow,
};
