import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/poster_model.dart';
import '../../data/repo/top_rated_movies_repo.dart';

part 'top_rated_movie_state.dart';

class TopRatedMovieCubit extends Cubit<TopRatedMovieState> {
  TopRatedMovieCubit({required this.postersRepo})
    : super(TopRatedMovieInitial());

  final TopRatedMoviesRepo postersRepo;
  List<PosterModel>? posters;

  Future<void> getTopRatedMovies() async {
    emit(TopRatedMovieLoading());
    try {
      posters = await postersRepo.getTopRatedMovies();
      emit(TopRatedMovieLoaded(posters: posters ?? []));
    } catch (e) {
      emit(TopRatedMovieFailed(errorMessage: e.toString()));
    }
  }
}