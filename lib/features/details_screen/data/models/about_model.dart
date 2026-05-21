import 'package:json_annotation/json_annotation.dart';

part 'about_model.g.dart';

@JsonSerializable()
class AboutModel {
  @JsonKey(name: "credits")
  final ActorResponse actors;
  @JsonKey(name: "production_companies")
  final List<CompanyModel> companies;
  @JsonKey(name: "budget")
  final int budget;
  @JsonKey(name: "revenue")
  final int revenue;
  @JsonKey(name: "softcore")
  final bool adultContent;

  AboutModel({
    required this.actors,
    required this.companies,
    required this.budget,
    required this.revenue,
    required this.adultContent,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) =>
      _$AboutModelFromJson(json);

  Map<String, dynamic> toJson() => _$AboutModelToJson(this);
}

@JsonSerializable()
class ActorResponse {
  @JsonKey(name: "cast")
  final List<ActorModel> movieActors;

  ActorResponse({required this.movieActors});

  factory ActorResponse.fromJson(Map<String, dynamic> json) =>
      _$ActorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActorResponseToJson(this);
}

@JsonSerializable()
class ActorModel {
  @JsonKey(name: "gender")
  final int gender;
  @JsonKey(name: "known_for_department")
  final String job;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "character")
  final String character;
  @JsonKey(name: "profile_path")
  final String? actorImage;

  ActorModel({
    required this.gender,
    required this.job,
    required this.name,
    required this.character,
    this.actorImage,
  });

  factory ActorModel.fromJson(Map<String, dynamic> json) =>
      _$ActorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActorModelToJson(this);
}

@JsonSerializable()
class CompanyModel {
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "origin_country")
  final String originCountry;
  @JsonKey(name: "logo_path")
  final String? logo;

  CompanyModel({required this.name, required this.originCountry, this.logo});

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}
