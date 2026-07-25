import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/models/genre_model.dart';
import 'package:movura/features/home/data/repo/home_repo.dart';
import 'package:movura/features/search/data/models/search_filter_type.dart';
import 'package:movura/features/search/data/repo/search_repo.dart';

import '../../../../core/models/poster_model.dart';

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

  Future<void> getSearchResults({required String query, int page = 1}) async {
    emit(SearchLoading(filter: currentFilter));
    try {
      _lastQuery = query;
      _allPosters = await searchRepo.getSearchResults(query: query, page: page);
      emit(
        SearchLoaded(
          posters: _applyFilter(_allPosters),
          filter: currentFilter,
          query: query,
        ),
      );
    } catch (e) {
      emit(SearchError(errorMessage: e.toString(), filter: currentFilter, query: query));
    }
  }

  void setFilter(SearchFilterType filter) {
    currentFilter = filter;
    selectedGenreId = null; // Reset genre when changing main filter
    if (_allPosters.isNotEmpty) {
      emit(
        SearchLoaded(
          posters: _applyFilter(_allPosters),
          filter: currentFilter,
          query: _lastQuery,
        ),
      );
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
        ),
      );
    }
  }

  List<PosterModel> _applyFilter(List<PosterModel> posters) {
    var filtered = List<PosterModel>.from(posters);
    final mediaType = currentFilter.mediaType;
    if (mediaType != null) {
      filtered = filtered
          .where((poster) => poster.mediaType == mediaType)
          .toList();
    }

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
