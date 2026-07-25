import 'package:json_annotation/json_annotation.dart';
import 'poster_model.dart';

part 'similar_model.g.dart';

@JsonSerializable()
class SimilarContentResponse {
  final PosterResponse? similar;
  final PosterResponse? recommendations;

  SimilarContentResponse({this.similar, this.recommendations});

  factory SimilarContentResponse.fromJson(Map<String, dynamic> json) =>
      _$SimilarContentResponseFromJson(json);
}
