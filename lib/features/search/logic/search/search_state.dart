part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchFounded extends SearchState {
  final List<PosterModel> posters;

  SearchFounded({required this.posters});
}

final class SearchFailed extends SearchState {
  final String errorMessage;

  SearchFailed({required this.errorMessage});
}
