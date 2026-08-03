enum SeeAllEndpoint {
  trendingMoviesDay,
  trendingMoviesWeek,
  popularMovies,
  topRatedMovies,
  upcomingMovies,
  nowPlayingMovies,
  trendingTvDay,
  trendingTvWeek,
  popularTv,
  topRatedTv,
  onTheAirTv,
  similarMovies,
  similarTv,
  moviesByGenre,
  tvByGenre,
}

class SeeAllArguments {
  final String title;
  final SeeAllEndpoint endpoint;
  final int? id;

  SeeAllArguments({required this.title, required this.endpoint, this.id});
}
