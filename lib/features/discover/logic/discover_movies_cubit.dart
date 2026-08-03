import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/models/poster_model.dart';
import '../data/repo/discover_repo.dart';

abstract class DiscoverMoviesState {}

class DiscoverMoviesInitial extends DiscoverMoviesState {}
class DiscoverMoviesLoading extends DiscoverMoviesState {}
class DiscoverMoviesLoaded extends DiscoverMoviesState {
  final List<PosterModel> trendingToday;
  final List<PosterModel> trendingWeek;
  final List<PosterModel> upcoming;
  final List<PosterModel> nowPlaying;
  final List<PosterModel> popular;
  final List<PosterModel> topRated;

  DiscoverMoviesLoaded({
    required this.trendingToday,
    required this.trendingWeek,
    required this.upcoming,
    required this.nowPlaying,
    required this.popular,
    required this.topRated,
  });
}
class DiscoverMoviesError extends DiscoverMoviesState {
  final String message;
  DiscoverMoviesError(this.message);
}

class DiscoverMoviesCubit extends Cubit<DiscoverMoviesState> {
  final DiscoverRepo _repo;
  DiscoverMoviesCubit(this._repo) : super(DiscoverMoviesInitial());

  Future<void> getDiscoverMovies() async {
    emit(DiscoverMoviesLoading());
    try {
      final results = await Future.wait([
        _repo.getTrendingMovies("day"),
        _repo.getTrendingMovies("week"),
        _repo.getMoviesByCategory("upcoming"),
        _repo.getMoviesByCategory("now_playing"),
        _repo.getMoviesByCategory("popular"),
        _repo.getMoviesByCategory("top_rated"),
      ]);

      emit(DiscoverMoviesLoaded(
        trendingToday: results[0],
        trendingWeek: results[1],
        upcoming: results[2],
        nowPlaying: results[3],
        popular: results[4],
        topRated: results[5],
      ));
    } catch (e) {
      emit(DiscoverMoviesError(e.toString()));
    }
  }
}
