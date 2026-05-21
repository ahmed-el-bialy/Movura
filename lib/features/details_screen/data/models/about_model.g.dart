// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutModel _$AboutModelFromJson(Map<String, dynamic> json) => AboutModel(
  actors: ActorResponse.fromJson(json['credits'] as Map<String, dynamic>),
  companies: (json['production_companies'] as List<dynamic>)
      .map((e) => CompanyModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  budget: (json['budget'] as num).toInt(),
  revenue: (json['revenue'] as num).toInt(),
  adultContent: json['softcore'] as bool,
);

Map<String, dynamic> _$AboutModelToJson(AboutModel instance) =>
    <String, dynamic>{
      'credits': instance.actors,
      'production_companies': instance.companies,
      'budget': instance.budget,
      'revenue': instance.revenue,
      'softcore': instance.adultContent,
    };

ActorResponse _$ActorResponseFromJson(Map<String, dynamic> json) =>
    ActorResponse(
      movieActors: (json['cast'] as List<dynamic>)
          .map((e) => ActorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ActorResponseToJson(ActorResponse instance) =>
    <String, dynamic>{'cast': instance.movieActors};

ActorModel _$ActorModelFromJson(Map<String, dynamic> json) => ActorModel(
  gender: (json['gender'] as num).toInt(),
  job: json['known_for_department'] as String,
  name: json['name'] as String,
  character: json['character'] as String,
  actorImage: json['profile_path'] as String?,
);

Map<String, dynamic> _$ActorModelToJson(ActorModel instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'known_for_department': instance.job,
      'name': instance.name,
      'character': instance.character,
      'profile_path': instance.actorImage,
    };

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel(
  name: json['name'] as String,
  originCountry: json['origin_country'] as String,
  logo: json['logo_path'] as String?,
);

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'origin_country': instance.originCountry,
      'logo_path': instance.logo,
    };
