import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/features/search/data/models/search_filter_type.dart';
import 'package:movura/features/search/data/repo/search_repo.dart';

import '../../../../core/models/poster_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchRepo}) : super(SearchInitial());

  final SearchRepo searchRepo;
  List<PosterModel> _allPosters = [];
  SearchFilterType currentFilter = SearchFilterType.all;
  String _lastQuery = '';

  Future<void> getSearchResults({required String query, int page = 1}) async {
    emit(SearchLoading(filter: currentFilter));
    try {
      _lastQuery = query;
      _allPosters = await searchRepo.getSearchResults(query: query, page: page);
      emit(
        SearchFounded(
          posters: _applyFilter(_allPosters),
          filter: currentFilter,
          query: query,
        ),
      );
    } catch (e) {
      emit(SearchFailed(errorMessage: e.toString(), filter: currentFilter));
    }
  }

  void setFilter(SearchFilterType filter) {
    currentFilter = filter;
    if (_allPosters.isNotEmpty) {
      emit(
        SearchFounded(
          posters: _applyFilter(_allPosters),
          filter: currentFilter,
          query: _lastQuery,
        ),
      );
    } else {
      emit(SearchInitial(filter: currentFilter));
    }
  }

  List<PosterModel> _applyFilter(List<PosterModel> posters) {
    final mediaType = currentFilter.mediaType;
    if (mediaType == null) return posters;
    return posters.where((poster) => poster.mediaType == mediaType).toList();
  }
}
