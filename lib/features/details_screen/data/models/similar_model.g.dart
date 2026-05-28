// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'similar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimilarMovieResponse _$SimilarMovieResponseFromJson(
  Map<String, dynamic> json,
) => SimilarMovieResponse(
  similar: json['similar'] == null
      ? null
      : SimilarContainer.fromJson(json['similar'] as Map<String, dynamic>),
  recommendations: json['recommendations'] == null
      ? null
      : RecommendationsContainer.fromJson(
          json['recommendations'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SimilarMovieResponseToJson(
  SimilarMovieResponse instance,
) => <String, dynamic>{
  'similar': instance.similar,
  'recommendations': instance.recommendations,
};

SimilarContainer _$SimilarContainerFromJson(Map<String, dynamic> json) =>
    SimilarContainer(
      page: (json['page'] as num?)?.toInt(),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => PosterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SimilarContainerToJson(SimilarContainer instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
    };

RecommendationsContainer _$RecommendationsContainerFromJson(
  Map<String, dynamic> json,
) => RecommendationsContainer(
  page: (json['page'] as num?)?.toInt(),
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => PosterModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalPages: (json['total_pages'] as num?)?.toInt(),
);

Map<String, dynamic> _$RecommendationsContainerToJson(
  RecommendationsContainer instance,
) => <String, dynamic>{
  'page': instance.page,
  'results': instance.results,
  'total_pages': instance.totalPages,
};
