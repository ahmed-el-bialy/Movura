import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/poster_model.dart';
import '../../data/repo/home_repo.dart';

part 'top_rated_movies_state.dart';

class TopRatedMovieCubit extends Cubit<TopRatedMovieState> {
  TopRatedMovieCubit({required this.postersRepo})
    : super(TopRatedMovieInitial());

  final HomeRepo postersRepo;
  List<PosterModel>? posters;

  Future<void> getTopRatedMovies() async {
    emit(TopRatedMovieLoading());
    try {
      posters = await postersRepo.getTopRatedMovies();
      emit(TopRatedMovieLoaded(posters: posters ?? []));
    } catch (e) {
      emit(TopRatedMovieError(errorMessage: e.toString()));
    }
  }
}
