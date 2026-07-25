part of 'search_cubit.dart';

@immutable
sealed class SearchState {
  const SearchState({this.filter = SearchFilterType.all});

  final SearchFilterType filter;
}

final class SearchInitial extends SearchState {
  const SearchInitial({super.filter});
}

final class SearchLoading extends SearchState {
  const SearchLoading({super.filter});
}

final class SearchLoaded extends SearchState {
  const SearchLoaded({
    required this.posters,
    required super.filter,
    required this.query,
  });

  final List<PosterModel> posters;
  final String query;
}

final class SearchError extends SearchState {
  const SearchError({
    required this.errorMessage,
    required super.filter,
    required this.query,
  });

  final String errorMessage;
  final String query;
}
