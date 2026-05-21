part of 'about_section_cubit.dart';

@immutable
sealed class AboutSectionState {}

final class AboutSectionInitial extends AboutSectionState {}

final class AboutSectionLoading extends AboutSectionState {}

final class AboutSectionLoaded extends AboutSectionState {
  final AboutModel model;

  AboutSectionLoaded({required this.model});
}

final class AboutSectionFailed extends AboutSectionState {
  final String errorMessage;

  AboutSectionFailed({required this.errorMessage});
}
