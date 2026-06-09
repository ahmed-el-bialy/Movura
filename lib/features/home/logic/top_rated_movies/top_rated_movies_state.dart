part of 'top_rated_movies_cubit.dart';

@immutable
sealed class TopRatedMovieState {}

final class TopRatedMovieInitial extends TopRatedMovieState {}

final class TopRatedMovieLoaded extends TopRatedMovieState {
   final List<PosterModel> posters;
   TopRatedMovieLoaded({required this.posters});
}

final class TopRatedMovieLoading extends TopRatedMovieState {}

final class TopRatedMovieFailed extends TopRatedMovieState {
  final String errorMessage;

  TopRatedMovieFailed({required this.errorMessage});
}
