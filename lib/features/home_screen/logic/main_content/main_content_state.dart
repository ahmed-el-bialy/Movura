part of 'main_content_cubit.dart';

@immutable
sealed class MainContentState {}

final class MainContentInitial extends MainContentState {}

final class MainContentLoaded extends MainContentState {
  final List<PosterModel> posters;

  MainContentLoaded({required this.posters});
}

final class MainContentLoading extends MainContentState {}

final class MainContentFailed extends MainContentState {
  final String errorMessage;

  MainContentFailed({required this.errorMessage});
}
