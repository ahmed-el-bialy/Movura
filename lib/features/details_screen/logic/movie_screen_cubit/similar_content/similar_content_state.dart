part of 'similar_content_cubit.dart';

@immutable
sealed class SimilarContentState {}

final class SimilarContentInitial extends SimilarContentState {}

final class SimilarContentLoading extends SimilarContentState {}

final class SimilarContentLoaded extends SimilarContentState {
  final SimilarContentResponse similarMovieResponse;

  SimilarContentLoaded({required this.similarMovieResponse});
}

final class SimilarContentFailed extends SimilarContentState {
  final String errorMessage;

  SimilarContentFailed({required this.errorMessage});
}
