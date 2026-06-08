import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/shared_models/similar_model.dart';
import '../../../data/repos/tv_repos/tv_similar_repo.dart';

part 'similar_content_state.dart';

class TvSeriesSimilarContentCubit extends Cubit<TvSeriesSimilarContentState> {
  TvSeriesSimilarContentCubit({required this.repo})
    : super(TvSimilarContentInitial());

  SimilarContentResponse? reviewResponse;

  final TvSimilarRepo repo;

  Future<void> getSimilarTvSeries({required int id}) async {
    emit(TvSimilarContentLoading());
    try {
      final similarContent = await repo.getSimilarTvSeries(id: id);
      emit(TvSimilarContentLoaded(similarContentResponse: similarContent));
    } catch (e) {
      emit(TvSimilarContentFailed(errorMessage: e.toString()));
    }
  }
}
