
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/features/details_screen/data/models/review_model.dart';
import 'package:movura/features/details_screen/data/repos/reviews_repo.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit({required this.repo}) : super(ReviewsInitial());
  List<ReviewsResponse>? reviewResponse;

  final ReviewsRepo repo;

  Future<void> getMovieReviews({required int id}) async {
    emit(ReviewsLoading());
    try {
      final  movieReviews = await repo.getMovieReviews(movieId: id);
      emit(ReviewsLoaded(response: movieReviews));
    } catch (e) {
      emit(ReviewsFailed(errorMessage: e.toString()));
    }
  }
}
