part of 'spotlight_cubit.dart';

sealed class SpotlightState {}

final class SpotlightInitial extends SpotlightState {}

final class SpotlightLoading extends SpotlightState {}

final class SpotlightLoaded extends SpotlightState {
  final List<PosterModel> posters;
  SpotlightLoaded({required this.posters});
}

final class SpotlightError extends SpotlightState {
  final String message;
  SpotlightError({required this.message});
}
