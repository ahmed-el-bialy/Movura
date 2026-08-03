import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/tv_series_repo.dart';
import 'package:movura/core/models/similar_model.dart';

part 'similar_content_state.dart';

class TvSeriesSimilarContentCubit extends Cubit<TvSeriesSimilarContentState> {
  TvSeriesSimilarContentCubit({required this.repo})
    : super(TvSimilarContentInitial());

  final TvSeriesRepo repo;

  Future<void> getSimilarTvSeries({required int id}) async {
    emit(TvSimilarContentLoading());
    try {
      final similarContent = await repo.getSimilarTvSeries(id: id);
      emit(TvSimilarContentLoaded(similarContentResponse: similarContent, id: id));
    } catch (e) {
      emit(TvSimilarContentError(errorMessage: e.toString()));
    }
  }
}
