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

final class SearchFounded extends SearchState {
  const SearchFounded({
    required this.posters,
    required super.filter,
    required this.query,
  });

  final List<PosterModel> posters;
  final String query;
}

final class SearchFailed extends SearchState {
  const SearchFailed({
    required this.errorMessage,
    required super.filter,
  });

  final String errorMessage;
}
