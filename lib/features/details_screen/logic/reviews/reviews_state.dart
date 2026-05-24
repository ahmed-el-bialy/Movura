part of 'reviews_cubit.dart';

@immutable
sealed class ReviewsState {}

final class ReviewsInitial extends ReviewsState {}

final class ReviewsLoading extends ReviewsState {}

final class ReviewsLoaded extends ReviewsState {
  final ReviewsResponse response;

  ReviewsLoaded({required this.response});
}

final class ReviewsFailed extends ReviewsState {
  final String errorMessage;

  ReviewsFailed({required this.errorMessage});
}
