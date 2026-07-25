part of 'reviews_cubit.dart';

@immutable
sealed class TvSeriesReviewsState {}

final class TvReviewsInitial extends TvSeriesReviewsState {}

final class TvReviewsLoading extends TvSeriesReviewsState {}

final class TvReviewsLoaded extends TvSeriesReviewsState {
  final List<ReviewModel> response;

  TvReviewsLoaded({required this.response});
}

final class TvReviewsError extends TvSeriesReviewsState {
  final String errorMessage;

  TvReviewsError({required this.errorMessage});
}
