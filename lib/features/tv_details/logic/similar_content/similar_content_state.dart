part of 'similar_content_cubit.dart';

@immutable
sealed class TvSeriesSimilarContentState {}

final class TvSimilarContentInitial extends TvSeriesSimilarContentState {}

final class TvSimilarContentLoading extends TvSeriesSimilarContentState {}

final class TvSimilarContentLoaded extends TvSeriesSimilarContentState {
  final SimilarContentResponse similarContentResponse;
  final int id;

  TvSimilarContentLoaded({required this.similarContentResponse, required this.id});
}

final class TvSimilarContentError extends TvSeriesSimilarContentState {
  final String errorMessage;

  TvSimilarContentError({required this.errorMessage});
}
