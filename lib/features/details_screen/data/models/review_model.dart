import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class MovieReviews {
  @JsonKey(name: "reviews")
  final ReviewsResponse reviews;

  MovieReviews({required this.reviews});

  factory MovieReviews.fromJson(Map<String, dynamic> json) =>
      _$MovieReviewsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieReviewsToJson(this);
}

@JsonSerializable()
class ReviewsResponse {
  @JsonKey(name: "results")
  final List<ReviewModel> reviewsList;

  ReviewsResponse({required this.reviewsList});

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsResponseToJson(this);
}

@JsonSerializable()
class ReviewModel {
  final String content;
  final String author;
  @JsonKey(name: "created_at")
  final String createdAt;

  @JsonKey(name: "author_details")
  final UserDetails userDetails;

  ReviewModel({
    required this.content,
    required this.author,
    required this.createdAt,
    required this.userDetails,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}

@JsonSerializable()
class UserDetails {
  @JsonKey(name: "avatar_path")
  final String? avatarPath;
  final String name;
  final double? rating;

  UserDetails({this.avatarPath, required this.name, this.rating});

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}
