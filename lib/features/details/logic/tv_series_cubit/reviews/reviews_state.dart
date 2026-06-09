part of 'reviews_cubit.dart';

@immutable
sealed class TvSeriesReviewsState {}

final class TvReviewsInitial extends TvSeriesReviewsState {}

final class TvReviewsLoading extends TvSeriesReviewsState {}

final class TvReviewsLoaded extends TvSeriesReviewsState {
  final List<ReviewModel> response;

  TvReviewsLoaded({required this.response});
}

final class TvReviewsFailed extends TvSeriesReviewsState {
  final String errorMessage;

  TvReviewsFailed({required this.errorMessage});
}
