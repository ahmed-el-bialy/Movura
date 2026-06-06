part of 'about_cubit.dart';

@immutable
sealed class AboutState {}

final class AboutInitial extends AboutState {}

final class AboutLoading extends AboutState {}

final class AboutSuccess extends AboutState {
  final AboutModel model;

  AboutSuccess({required this.model});
}

final class AboutFailed extends AboutState {
  final String errorMessage;

  AboutFailed({required this.errorMessage});
}
