part of 'about_tv_cubit.dart';

@immutable
sealed class AboutTvState {}

final class AboutTvInitial extends AboutTvState {}

final class AboutTvLoading extends AboutTvState {}

final class AboutTvLoaded extends AboutTvState {
  final AboutTvSeriesModel model;

  AboutTvLoaded({required this.model});
}

final class AboutTvError extends AboutTvState {
  final String errorMessage;

  AboutTvError({required this.errorMessage});
}
