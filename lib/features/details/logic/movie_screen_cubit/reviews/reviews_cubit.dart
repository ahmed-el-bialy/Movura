import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/features/details/data/repos/movies_repo.dart';

import '../../../data/models/shared_models/review_model.dart';



part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit({required this.repo}) : super(ReviewsInitial());
  List<ReviewsResponse>? reviewResponse;

  final MovieRepo repo;

  Future<void> getMovieReviews({required int id}) async {
    emit(ReviewsLoading());
    try {
      final movieReviews = await repo.getMovieReviews(movieId: id);
      emit(ReviewsLoaded(response: movieReviews));
    } catch (e) {
      emit(ReviewsFailed(errorMessage: e.toString()));
    }
  }
}
