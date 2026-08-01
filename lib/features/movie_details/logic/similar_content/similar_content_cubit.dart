import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/movies_repo.dart';
import '../../../../core/models/similar_model.dart';

part 'similar_content_state.dart';

class SimilarContentCubit extends Cubit<SimilarContentState> {
  SimilarContentCubit({required this.repo}) : super(SimilarContentInitial());

  final MovieRepo repo;

  Future<void> getSimilarMovies({required int id}) async {
    emit(SimilarContentLoading());
    try {
      final similarContent = await repo.getSimilarMovies(id: id);
      emit(SimilarContentLoaded(similarMovieResponse: similarContent, id: id));
    } catch (e) {
      emit(SimilarContentError(errorMessage: e.toString()));
    }
  }
}
