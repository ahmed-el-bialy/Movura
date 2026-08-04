// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_tv_series_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutTvSeriesModel _$AboutTvSeriesModelFromJson(Map<String, dynamic> json) =>
    AboutTvSeriesModel(
      id: (json['id'] as num).toInt(),
      language: json['original_language'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      title: json['name'] as String?,
      originalTitle: json['original_name'] as String?,
      overview: json['overview'] as String?,
      rating: (json['vote_average'] as num?)?.toDouble(),
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      type: json['type'] as String?,
      inProduction: json['in_production'] as bool?,
      numberOfSeasons: (json['number_of_seasons'] as num?)?.toInt(),
      numberOfEpisodes: (json['number_of_episodes'] as num?)?.toInt(),
      episodeRunTime: (json['episode_run_time'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      networks: (json['networks'] as List<dynamic>?)
          ?.map((e) => TvNetworkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      companies: (json['production_companies'] as List<dynamic>?)
          ?.map((e) => CompanyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) => TvSeasonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      actors: json['credits'] == null
          ? null
          : TvActorResponse.fromJson(json['credits'] as Map<String, dynamic>),
      homepage: json['homepage'] as String?,
      adultContent: json['adult'] as bool?,
      mediaImages: json['images'] == null
          ? null
          : TvImagesResponse.fromJson(json['images'] as Map<String, dynamic>),
      tvVideos: json['videos'] == null
          ? null
          : TvVideoResponse.fromJson(json['videos'] as Map<String, dynamic>),
      startAirDate: json['first_air_date'] as String?,
      endAirDate: json['last_air_date'] as String?,
      watchProviders: json['watch/providers'] == null
          ? null
          : WatchProviderResponse.fromJson(
              json['watch/providers'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AboutTvSeriesModelToJson(AboutTvSeriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'original_language': instance.language,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'name': instance.title,
      'original_name': instance.originalTitle,
      'overview': instance.overview,
      'vote_average': instance.rating,
      'first_air_date': instance.startAirDate,
      'last_air_date': instance.endAirDate,
      'status': instance.status,
      'tagline': instance.tagline,
      'type': instance.type,
      'in_production': instance.inProduction,
      'number_of_seasons': instance.numberOfSeasons,
      'number_of_episodes': instance.numberOfEpisodes,
      'episode_run_time': instance.episodeRunTime,
      'genres': instance.genres,
      'networks': instance.networks,
      'production_companies': instance.companies,
      'seasons': instance.seasons,
      'credits': instance.actors,
      'homepage': instance.homepage,
      'adult': instance.adultContent,
      'images': instance.mediaImages,
      'videos': instance.tvVideos,
      'watch/providers': instance.watchProviders,
    };

TvSeasonModel _$TvSeasonModelFromJson(Map<String, dynamic> json) =>
    TvSeasonModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      seasonNumber: (json['season_number'] as num).toInt(),
      episodeCount: (json['episode_count'] as num?)?.toInt(),
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      airDate: json['air_date'] as String?,
    );

Map<String, dynamic> _$TvSeasonModelToJson(TvSeasonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'season_number': instance.seasonNumber,
      'episode_count': instance.episodeCount,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'air_date': instance.airDate,
    };

TvNetworkModel _$TvNetworkModelFromJson(Map<String, dynamic> json) =>
    TvNetworkModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      logo: json['logo_path'] as String?,
      originCountry: json['origin_country'] as String?,
    );

Map<String, dynamic> _$TvNetworkModelToJson(TvNetworkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo_path': instance.logo,
      'origin_country': instance.originCountry,
    };

TvActorResponse _$TvActorResponseFromJson(Map<String, dynamic> json) =>
    TvActorResponse(
      tvActors: (json['cast'] as List<dynamic>?)
          ?.map((e) => ActorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>?)
          ?.map((e) => ActorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TvActorResponseToJson(TvActorResponse instance) =>
    <String, dynamic>{'cast': instance.tvActors, 'crew': instance.crew};

TvVideoResponse _$TvVideoResponseFromJson(Map<String, dynamic> json) =>
    TvVideoResponse(
      videoList: (json['results'] as List<dynamic>?)
          ?.map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TvVideoResponseToJson(TvVideoResponse instance) =>
    <String, dynamic>{'results': instance.videoList};

TvImagesResponse _$TvImagesResponseFromJson(Map<String, dynamic> json) =>
    TvImagesResponse(
      backdropImages: (json['backdrops'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      logoImages: (json['logos'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      stills: (json['stills'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      posters: (json['posters'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TvImagesResponseToJson(TvImagesResponse instance) =>
    <String, dynamic>{
      'backdrops': instance.backdropImages,
      'logos': instance.logoImages,
      'stills': instance.stills,
      'posters': instance.posters,
    };
