import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/poster_model.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  final String id;
  final String email;
  final String name;
  @JsonKey(fromJson: _parsePosterList)
  final List<PosterModel>? favorites;
  @JsonKey(fromJson: _parsePosterList)
  final List<PosterModel>? watched;
  @JsonKey(fromJson: _parsePosterList)
  final List<PosterModel>? toWatch;
  @JsonKey(fromJson: _parsePosterList)
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

  static List<PosterModel> _parsePosterList(dynamic jsonVal) {
    if (jsonVal == null) return [];
    if (jsonVal is Map) {
      return jsonVal.values
          .where((v) => v != null)
          .map((v) => PosterModel.fromJson(Map<String, dynamic>.from(v as Map)))
          .toList();
    }
    if (jsonVal is List) {
      return jsonVal
          .where((v) => v != null)
          .map((v) => PosterModel.fromJson(Map<String, dynamic>.from(v as Map)))
          .toList();
    }
    return [];
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

