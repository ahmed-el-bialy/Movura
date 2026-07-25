// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'similar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimilarContentResponse _$SimilarContentResponseFromJson(
  Map<String, dynamic> json,
) => SimilarContentResponse(
  similar: json['similar'] == null
      ? null
      : PosterResponse.fromJson(json['similar'] as Map<String, dynamic>),
  recommendations: json['recommendations'] == null
      ? null
      : PosterResponse.fromJson(
          json['recommendations'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SimilarContentResponseToJson(
  SimilarContentResponse instance,
) => <String, dynamic>{
  'similar': instance.similar,
  'recommendations': instance.recommendations,
};
