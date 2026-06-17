import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/features/details/data/repos/movies_repo.dart';

import '../../../data/models/shared_models/similar_model.dart';

part 'similar_content_state.dart';

class SimilarContentCubit extends Cubit<SimilarContentState> {
  SimilarContentCubit({required this.repo}) : super(SimilarContentInitial());

  SimilarContentResponse? reviewResponse;

  final MovieRepo repo;

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
