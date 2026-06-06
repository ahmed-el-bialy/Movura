part of 'about_tv_cubit.dart';

@immutable
sealed class AboutTvState {}

final class AboutTvInitial extends AboutTvState {}

final class AboutInitial extends AboutTvInitial {}

final class AboutLoading extends AboutTvInitial {}

final class AboutTvLoaded extends AboutTvInitial {
  final AboutTvSeriesModel model;

  AboutTvLoaded({required this.model});
}

final class AboutTvFailed extends AboutTvInitial {
  final String errorMessage;

  AboutTvFailed({required this.errorMessage});
}
