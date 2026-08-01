import 'package:json_annotation/json_annotation.dart';

part 'company_model.g.dart';

@JsonSerializable()
class CompanyModel {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "origin_country")
  final String? originCountry;
  @JsonKey(name: "logo_path")
  final String? logo;

  CompanyModel({this.name, this.originCountry, this.logo});

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}
