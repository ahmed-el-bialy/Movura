import 'package:json_annotation/json_annotation.dart';

part 'video_model.g.dart';

@JsonSerializable()
class VideoModel {
  final String? id;
  final String? key;
  final String? name;
  final String? site;
  final int? size;
  final String? type;
  final bool? official;

  VideoModel({
    this.id,
    this.key,
    this.name,
    this.site,
    this.size,
    this.type,
    this.official,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}
