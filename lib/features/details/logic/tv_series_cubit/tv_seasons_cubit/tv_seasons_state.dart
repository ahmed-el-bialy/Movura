part of 'tv_seasons_cubit.dart';

@immutable
sealed class TvSeasonsState {}

final class TvSeasonsInitial extends TvSeasonsState {}

final class TvSeasonsLoading extends TvSeasonsInitial {}

final class TvSeasonsLoaded extends TvSeasonsInitial {
  final SeasonDetailsModel seasonDetails;

  TvSeasonsLoaded({required this.seasonDetails});
}

final class TvSeasonsFailed extends TvSeasonsInitial {
  final String errorMessage;

  TvSeasonsFailed({required this.errorMessage});
}

