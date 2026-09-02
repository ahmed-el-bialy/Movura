part of 'spotlight_cubit.dart';

@immutable
sealed class SpotlightState {}

final class SpotlightInitial extends SpotlightState {}

final class SpotlightLoaded extends SpotlightState {
  final List<PosterModel> posters;

  SpotlightLoaded({required this.posters});
}

final class SpotlightLoading extends SpotlightState {}

final class SpotlightError extends SpotlightState {
  final String errorMessage;

  SpotlightError({required this.errorMessage});
}
