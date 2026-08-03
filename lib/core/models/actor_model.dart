import 'package:json_annotation/json_annotation.dart';

part 'actor_model.g.dart';

@JsonSerializable()
class ActorModel {
  final int? id;
  @JsonKey(name: "known_for_department")
  final String? job;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "character")
  final String? character;
  @JsonKey(name: "profile_path")
  final String? actorImage;

  ActorModel({this.id, this.job, this.name, this.character, this.actorImage});

  factory ActorModel.fromJson(Map<String, dynamic> json) =>
      _$ActorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActorModelToJson(this);
}
