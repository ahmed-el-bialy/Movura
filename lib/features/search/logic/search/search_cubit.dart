import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/features/search/data/repo/search_repo.dart';

import '../../../../core/models/poster_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchRepo, required this.posters})
    : super(SearchInitial());

  final SearchRepo searchRepo;
  List<PosterModel>? posters;

  Future<void> getSearchResults({required String query, int? page = 1}) async {
    emit(SearchLoading());
    try {
      posters = await searchRepo.getSearchResults(
        query: query,
        page: page ?? 1,
      );
      emit(SearchFounded(posters: posters ?? []));
    } catch (e) {
      emit(SearchFailed(errorMessage: e.toString()));
    }
  }
}
