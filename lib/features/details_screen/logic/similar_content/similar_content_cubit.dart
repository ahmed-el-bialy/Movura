import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movura/features/details_screen/data/models/similar_model.dart';
import 'package:movura/features/details_screen/data/repos/similar_repo.dart';

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
