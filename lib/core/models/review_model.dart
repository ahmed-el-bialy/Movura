import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewsResponse {
  @JsonKey(name: "results")
  final List<ReviewModel>? reviewsList;

  ReviewsResponse({this.reviewsList});

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewsResponseFromJson(json);
}

@JsonSerializable()
class ReviewModel {
  final String? author;
  final String? content;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "author_details")
  final AuthorDetails? authorDetails;

  ReviewModel({
    this.author,
    this.content,
    this.createdAt,
    this.authorDetails,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}

@JsonSerializable()
class AuthorDetails {
  final String? name;
  final String? username;
  @JsonKey(name: "avatar_path")
  final String? avatarPath;
  final double? rating;

  AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> json) =>
      _$AuthorDetailsFromJson(json);
}
