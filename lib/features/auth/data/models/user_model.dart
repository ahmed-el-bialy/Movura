import 'package:json_annotation/json_annotation.dart';
import 'package:movura/core/models/poster_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String email;
  final String name;
  final List<PosterModel>? favorites;
  final List<PosterModel>? watched;
  final List<PosterModel>? toWatch;
  final List<PosterModel>? watchNow;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.favorites,
    this.watched,
    this.toWatch,
    this.watchNow,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
