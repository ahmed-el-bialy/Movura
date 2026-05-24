// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsResponse _$ReviewsResponseFromJson(Map<String, dynamic> json) =>
    ReviewsResponse(
      reviewsList: (json['results'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewsResponseToJson(ReviewsResponse instance) =>
    <String, dynamic>{'results': instance.reviewsList};

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
  content: json['content'] as String,
  author: json['author'] as String,
  createdAt: json['created_at'] as String,
  userDetails: UserDetails.fromJson(
    json['author_details'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'author': instance.author,
      'created_at': instance.createdAt,
      'author_details': instance.userDetails,
    };

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
  avatarPath: json['avatar_path'] as String?,
  name: json['name'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
);

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'avatar_path': instance.avatarPath,
      'name': instance.name,
      'rating': instance.rating,
    };
