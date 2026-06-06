import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/movie_models/similar_model.dart';
import '../../../data/repos/movie_repos/similar_repo.dart';

part 'similar_content_state.dart';

class SimilarContentCubit extends Cubit<SimilarContentState> {
  SimilarContentCubit({required this.repo}) : super(SimilarContentInitial());

  SimilarMovieResponse? reviewResponse;

  final SimilarRepo repo;

  Future<void> getSimilarMovies({required int id}) async {
    emit(SimilarContentLoading());
    try {
      final similarContent = await repo.getSimilarMovies(movieId: id);
      emit(SimilarContentLoaded(similarMovieResponse: similarContent));
    } catch (e) {
      emit(SimilarContentFailed(errorMessage: e.toString()));
    }
  }
}
