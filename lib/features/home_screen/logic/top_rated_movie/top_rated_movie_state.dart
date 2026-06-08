part of 'top_rated_movie_cubit.dart';

@immutable
sealed class TpoRatedMovieState {}

final class TopRatedMovieInitial extends TpoRatedMovieState {}

final class TopRatedMovieLoaded extends TpoRatedMovieState {
   final List<PosterModel> posters;
   TopRatedMovieLoaded({required this.posters});
}

final class TopRatedMovieLoading extends TpoRatedMovieState {}

final class TopRatedMovieFailed extends TpoRatedMovieState {
  final String errorMessage;

  TopRatedMovieFailed({required this.errorMessage});
}
