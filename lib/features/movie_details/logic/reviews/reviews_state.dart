part of 'reviews_cubit.dart';

@immutable
sealed class ReviewsState {}

final class ReviewsInitial extends ReviewsState {}

final class ReviewsLoading extends ReviewsState {}

final class ReviewsLoaded extends ReviewsState {
  final List<ReviewModel> response;

  ReviewsLoaded({required this.response});
}

final class ReviewsError extends ReviewsState {
  final String errorMessage;

  ReviewsError({required this.errorMessage});
}
