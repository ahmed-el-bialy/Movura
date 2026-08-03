import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movura/core/models/genre_model.dart';
import 'package:movura/core/models/poster_model.dart';
import '../../../home/data/repo/home_repo.dart';
import '../../data/models/search_filter_type.dart';
import '../../data/repo/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchRepo, required this.homeRepo})
    : super(SearchInitial());

  final SearchRepo searchRepo;
  final HomeRepo homeRepo;
  List<PosterModel> _allPosters = [];
  SearchFilterType currentFilter = SearchFilterType.all;
  int? selectedGenreId;
  bool sortByRating = false;
  String _lastQuery = '';

  int _currentPage = 1;
  bool _hasReachedMax = false;

  List<GenreModel> movieGenres = [];
  List<GenreModel> tvGenres = [];

  Future<void> fetchGenres() async {
    try {
      final movieRes = await homeRepo.homeWebServices.getMovieGenres();
      movieGenres = movieRes.genres;
      final tvRes = await homeRepo.homeWebServices.getTvGenres();
      tvGenres = tvRes.genres;
    } catch (_) {}
  }

  Future<void> getSearchResults({required String query}) async {
    emit(SearchLoading(filter: currentFilter));
    try {
      _lastQuery = query;
      _currentPage = 1;
      _hasReachedMax = false;
      _allPosters = await searchRepo.getSearchResults(
        query: query,
        filterType: currentFilter,
        page: _currentPage,
      );
      
      if (_allPosters.length < 20) {
        _hasReachedMax = true;
      }

      emit(
        SearchLoaded(
          posters: _applyFilter(_allPosters),
          filter: currentFilter,
          query: query,
          hasReachedMax: _hasReachedMax,
        ),
      );
    } catch (e) {
      emit(
        SearchError(
          errorMessage: e.toString(),
          filter: currentFilter,
          query: query,
        ),
      );
    }
  }

  Future<void> loadMore() async {
    if (_hasReachedMax || state is! SearchLoaded || (state as SearchLoaded).isLoadingMore) return;

    final currentState = state as SearchLoaded;
    emit(
      SearchLoaded(
        posters: currentState.posters,
        filter: currentState.filter,
        query: currentState.query,
        hasReachedMax: currentState.hasReachedMax,
        isLoadingMore: true,
      ),
    );

    try {
      _currentPage++;
      final newPosters = await searchRepo.getSearchResults(
        query: _lastQuery,
        filterType: currentFilter,
        page: _currentPage,
      );

      if (newPosters.isEmpty || newPosters.length < 20) {
        _hasReachedMax = true;
      }

      _allPosters.addAll(newPosters);

      emit(
        SearchLoaded(
          posters: _applyFilter(_allPosters),
          filter: currentFilter,
          query: _lastQuery,
          hasReachedMax: _hasReachedMax,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      _hasReachedMax = true;
      emit(
        SearchLoaded(
          posters: _applyFilter(_allPosters),
          filter: currentFilter,
          query: _lastQuery,
          hasReachedMax: _hasReachedMax,
          isLoadingMore: false,
        ),
      );
    }
  }

  void setFilter(SearchFilterType filter) {
    currentFilter = filter;
    selectedGenreId = null;
    if (_lastQuery.isNotEmpty) {
      getSearchResults(query: _lastQuery);
    } else {
      emit(SearchInitial(filter: currentFilter));
    }
  }

  void setGenreFilter(int? genreId) {
    selectedGenreId = genreId;
    if (_allPosters.isNotEmpty) {
      emit(
        SearchLoaded(
          posters: _applyFilter(_allPosters),
          filter: currentFilter,
          query: _lastQuery,
          hasReachedMax: _hasReachedMax,
        ),
      );
    }
  }

  void setSortByRating(bool sortBy) {
    sortByRating = sortBy;
    if (_allPosters.isNotEmpty) {
      emit(
        SearchLoaded(
          posters: _applyFilter(_allPosters),
          filter: currentFilter,
          query: _lastQuery,
          hasReachedMax: _hasReachedMax,
        ),
      );
    }
  }

  List<PosterModel> _applyFilter(List<PosterModel> posters) {
    var filtered = List<PosterModel>.from(posters);

    if (selectedGenreId != null) {
      filtered = filtered
          .where(
            (poster) => poster.genreIds?.contains(selectedGenreId) ?? false,
          )
          .toList();
    }

    if (sortByRating) {
      filtered.sort(
        (a, b) => (b.voteAverage ?? 0.0).compareTo(a.voteAverage ?? 0.0),
      );
    }

    return filtered;
  }
}
