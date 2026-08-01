// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutModel _$AboutModelFromJson(Map<String, dynamic> json) => AboutModel(
  id: (json['id'] as num).toInt(),
  language: json['original_language'] as String?,
  posterPath: json['poster_path'] as String?,
  title: json['title'] as String?,
  originalTitle: json['original_title'] as String?,
  overview: json['overview'] as String?,
  runtime: (json['runtime'] as num?)?.toDouble(),
  rating: (json['vote_average'] as num?)?.toDouble(),
  genres: (json['genres'] as List<dynamic>?)
      ?.map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  actors: json['credits'] == null
      ? null
      : ActorResponse.fromJson(json['credits'] as Map<String, dynamic>),
  companies: (json['production_companies'] as List<dynamic>?)
      ?.map((e) => CompanyModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  budget: (json['budget'] as num?)?.toInt(),
  revenue: (json['revenue'] as num?)?.toInt(),
  homepage: json['homepage'] as String?,
  tagline: json['tagline'] as String?,
  status: json['status'] as String?,
  adultContent: json['adult'] as bool?,
  mediaImages: json['images'] == null
      ? null
      : ImagesResponse.fromJson(json['images'] as Map<String, dynamic>),
  movieVideos: json['videos'] == null
      ? null
      : VideoResponse.fromJson(json['videos'] as Map<String, dynamic>),
  watchProviders: json['watch/providers'] == null
      ? null
      : WatchProviderResponse.fromJson(
          json['watch/providers'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AboutModelToJson(AboutModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'original_language': instance.language,
      'poster_path': instance.posterPath,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'runtime': instance.runtime,
      'vote_average': instance.rating,
      'genres': instance.genres,
      'credits': instance.actors,
      'production_companies': instance.companies,
      'budget': instance.budget,
      'revenue': instance.revenue,
      'homepage': instance.homepage,
      'tagline': instance.tagline,
      'status': instance.status,
      'adult': instance.adultContent,
      'images': instance.mediaImages,
      'videos': instance.movieVideos,
      'watch/providers': instance.watchProviders,
    };

VideoResponse _$VideoResponseFromJson(Map<String, dynamic> json) =>
    VideoResponse(
      videoList: (json['results'] as List<dynamic>?)
          ?.map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideoResponseToJson(VideoResponse instance) =>
    <String, dynamic>{'results': instance.videoList};

ImagesResponse _$ImagesResponseFromJson(Map<String, dynamic> json) =>
    ImagesResponse(
      backdropImages: (json['backdrops'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      logoImages: (json['logos'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ImagesResponseToJson(ImagesResponse instance) =>
    <String, dynamic>{
      'backdrops': instance.backdropImages,
      'logos': instance.logoImages,
    };

ActorResponse _$ActorResponseFromJson(Map<String, dynamic> json) =>
    ActorResponse(
      movieActors: (json['cast'] as List<dynamic>?)
          ?.map((e) => ActorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ActorResponseToJson(ActorResponse instance) =>
    <String, dynamic>{'cast': instance.movieActors};
