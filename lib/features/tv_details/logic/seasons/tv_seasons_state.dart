part of 'tv_seasons_cubit.dart';

@immutable
sealed class TvSeasonsState {}

final class TvSeasonsInitial extends TvSeasonsState {}

final class TvSeasonsLoading extends TvSeasonsState {}

final class TvSeasonsLoaded extends TvSeasonsState {
  final SeasonDetailsModel seasonDetails;

  TvSeasonsLoaded({required this.seasonDetails});
}

final class TvSeasonsError extends TvSeasonsState {
  final String errorMessage;

  TvSeasonsError({required this.errorMessage});
}

