part of 'top_rated_tv_series_cubit.dart';

@immutable
sealed class TopRatedTvSeriesState {}

final class TopRatedTvSeriesInitial extends TopRatedTvSeriesState {}

final class TopRatedTvSeriesLoaded extends TopRatedTvSeriesState {
  final List<PosterModel> posters;

  TopRatedTvSeriesLoaded({required this.posters});
}

final class TopRatedTvSeriesLoading extends TopRatedTvSeriesState {}

final class TopRatedTvSeriesFailed extends TopRatedTvSeriesState {
  final String errorMessage;

  TopRatedTvSeriesFailed({required this.errorMessage});
}
