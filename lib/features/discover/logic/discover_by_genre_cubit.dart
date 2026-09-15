import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/models/genre_model.dart';
import 'package:movura/core/networking/api_error_handler.dart';

import '../data/repo/discover_repo.dart';

abstract class DiscoverByGenreState {}

class DiscoverByGenreInitial extends DiscoverByGenreState {}

class DiscoverByGenreLoading extends DiscoverByGenreState {}

class DiscoverByGenreLoaded extends DiscoverByGenreState {
  final List<GenreModel> genres;

  DiscoverByGenreLoaded(this.genres);
}

class DiscoverByGenreError extends DiscoverByGenreState {
  final String message;

  DiscoverByGenreError(this.message);
}

class DiscoverByGenreCubit extends Cubit<DiscoverByGenreState> {
  final DiscoverRepo _discoverRepo;

  DiscoverByGenreCubit(this._discoverRepo) : super(DiscoverByGenreInitial());

  Future<void> getGenres(bool isMovie) async {
    emit(DiscoverByGenreLoading());
    try {
      final response = isMovie
          ? await _discoverRepo.getMovieGenres()
          : await _discoverRepo.getTvGenres();

      emit(DiscoverByGenreLoaded(response.genres));
    } catch (e) {
      emit(DiscoverByGenreError(ApiErrorHandler.handle(e)));
    }
  }
}
