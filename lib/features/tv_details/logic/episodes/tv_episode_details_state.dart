part of 'tv_episode_details_cubit.dart';

@immutable
sealed class TvEpisodeDetailsState {}

final class TvEpisodeDetailsInitial extends TvEpisodeDetailsState {}

final class TvEpisodeDetailsLoading extends TvEpisodeDetailsState {}

final class TvEpisodeDetailsLoaded extends TvEpisodeDetailsState {
  final EpisodeDetailsModel episodeDetails;

  TvEpisodeDetailsLoaded({required this.episodeDetails});
}

final class TvEpisodeDetailsError extends TvEpisodeDetailsState {
  final String errorMessage;

  TvEpisodeDetailsError({required this.errorMessage});
}
