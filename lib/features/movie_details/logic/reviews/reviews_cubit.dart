import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/review_model.dart';
import '../../data/repos/movies_repo.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit({required this.repo}) : super(ReviewsInitial());

  final MovieRepo repo;

  Future<void> getMovieReviews({required int id}) async {
    emit(ReviewsLoading());
    try {
      final movieReviews = await repo.getMovieReviews(id: id);
      emit(ReviewsLoaded(response: movieReviews));
    } catch (e) {
      emit(ReviewsError(errorMessage: e.toString()));
    }
  }
}
