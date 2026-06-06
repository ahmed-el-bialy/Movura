import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';
@JsonSerializable()
class ImageModel {
  @JsonKey(name: "file_path")
  final String? imagePath;

  ImageModel({this.imagePath});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
