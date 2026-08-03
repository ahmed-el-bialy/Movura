import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/tv_series_repo.dart';
import 'package:movura/core/models/review_model.dart';

part 'reviews_state.dart';

class TvSeriesReviewsCubit extends Cubit<TvSeriesReviewsState> {
  TvSeriesReviewsCubit({required this.repo}) : super(TvReviewsInitial());

  final TvSeriesRepo repo;

  Future<void> getTvSeriesReviews({required int id}) async {
    emit(TvReviewsLoading());
    try {
      final reviews = await repo.getTvSeriesReviews(id: id);
      emit(TvReviewsLoaded(response: reviews));
    } catch (e) {
      emit(TvReviewsError(errorMessage: e.toString()));
    }
  }
}
