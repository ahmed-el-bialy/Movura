import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/features/details/data/repos/tv_series_repo.dart';

import '../../../data/models/shared_models/review_model.dart';

part 'reviews_state.dart';

class TvSeriesReviewsCubit extends Cubit<TvSeriesReviewsState> {
  TvSeriesReviewsCubit({required this.repo}) : super(TvReviewsInitial());
  List<ReviewsResponse>? reviewResponse;

  final TvSeriesRepo repo;

  Future<void> getTvSeriesReviews({required int id}) async {
    emit(TvReviewsLoading());
    try {
      final movieReviews = await repo.getTvSeriesReviews(id: id);
      emit(TvReviewsLoaded(response: movieReviews));
    } catch (e) {
      emit(TvReviewsFailed(errorMessage: e.toString()));
    }
  }
}
