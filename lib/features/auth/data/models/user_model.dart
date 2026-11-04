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
    final posters = <int, PosterModel>{};

    void visit(dynamic value) {
      if (value is List) {
        for (final item in value) {
          visit(item);
        }
        return;
      }
      if (value is! Map) return;

      final map = Map<String, dynamic>.from(value);
      if (map.containsKey('id')) {
        final poster = PosterModel.fromJson(map);
        if (poster.id != 0) posters[poster.id] = poster;
        return;
      }
      for (final item in map.values) {
        visit(item);
      }
    }

    visit(jsonVal);
    return posters.values.toList();
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'] is Map
        ? Map<String, dynamic>.from(json['profile'] as Map)
        : json;
    final library = json['library'] is Map
        ? Map<String, dynamic>.from(json['library'] as Map)
        : null;

    return UserModel(
      id: profile['id']?.toString() ?? '',
      email: profile['email']?.toString() ?? '',
      name: profile['name']?.toString() ?? 'Cinematic Explorer',
      favorites: _parsePosterList(library?['favorites'] ?? json['favorites']),
      watched: _parsePosterList(library?['watched'] ?? json['watched']),
      toWatch: _parsePosterList(library?['toWatch'] ?? json['toWatch']),
      watchNow: _parsePosterList(library?['watchNow'] ?? json['watchNow']),
    );
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
