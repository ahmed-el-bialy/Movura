part of 'about_cubit.dart';

@immutable
sealed class AboutState {}

final class AboutInitial extends AboutState {}

final class AboutLoading extends AboutState {}

final class AboutLoaded extends AboutState {
  final AboutModel model;

  AboutLoaded({required this.model});
}

final class AboutError extends AboutState {
  final String errorMessage;

  AboutError({required this.errorMessage});
}
