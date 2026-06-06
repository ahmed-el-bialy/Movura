
import 'package:json_annotation/json_annotation.dart';

part 'video_model.g.dart';
@JsonSerializable()
class VideoModel {
  final String id;
  final String key;
  final String name;
  final String site;
  final int size;
  final String type;
  final bool official;

  VideoModel({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}