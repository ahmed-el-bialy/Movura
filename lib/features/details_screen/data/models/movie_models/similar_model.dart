import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/models/poster_model.dart';

part 'similar_model.g.dart';

@JsonSerializable()
class SimilarMovieResponse {
  @JsonKey(name: "similar")
  final SimilarContainer? similar;

  @JsonKey(name: "recommendations")
  final RecommendationsContainer? recommendations;

  SimilarMovieResponse({this.similar, this.recommendations});

  factory SimilarMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$SimilarMovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SimilarMovieResponseToJson(this);
}

@JsonSerializable()
class SimilarContainer {
  final int? page;

  @JsonKey(name: "results")
  final List<PosterModel>? results;

  @JsonKey(name: "total_pages")
  final int? totalPages;

  SimilarContainer({this.page, this.results, this.totalPages});

  factory SimilarContainer.fromJson(Map<String, dynamic> json) =>
      _$SimilarContainerFromJson(json);

  Map<String, dynamic> toJson() => _$SimilarContainerToJson(this);
}

@JsonSerializable()
class RecommendationsContainer {
  final int? page;

  @JsonKey(name: "results")
  final List<PosterModel>? results;

  @JsonKey(name: "total_pages")
  final int? totalPages;

  RecommendationsContainer({this.page, this.results, this.totalPages});

  factory RecommendationsContainer.fromJson(Map<String, dynamic> json) =>
      _$RecommendationsContainerFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationsContainerToJson(this);
}
