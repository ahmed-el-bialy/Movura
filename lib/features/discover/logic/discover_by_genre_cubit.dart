import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/models/genre_model.dart';
import '../../home/data/repo/home_repo.dart';

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
  final HomeRepo _homeRepo;
  DiscoverByGenreCubit(this._homeRepo) : super(DiscoverByGenreInitial());

  Future<void> getGenres(bool isMovie) async {
    emit(DiscoverByGenreLoading());
    try {
      final response = isMovie 
        ? await _homeRepo.homeWebServices.getMovieGenres() 
        : await _homeRepo.homeWebServices.getTvGenres();
      
      emit(DiscoverByGenreLoaded(response.genres));
    } catch (e) {
      emit(DiscoverByGenreError(e.toString()));
    }
  }
}
