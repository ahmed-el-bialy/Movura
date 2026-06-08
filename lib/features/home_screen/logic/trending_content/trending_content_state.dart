part of 'trending_content_cubit.dart';

@immutable
sealed class TrendingContentState {}

final class TrendingContentInitial extends TrendingContentState {}

final class TrendingContentLoaded extends TrendingContentState {
  final List<PosterModel> posters;

  TrendingContentLoaded({required this.posters});
}

final class TrendingContentLoading extends TrendingContentState {}

final class TrendingContentFailed extends TrendingContentState {
  final String errorMessage;

  TrendingContentFailed({required this.errorMessage});
}
