import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3/';

  static String get apiKey => dotenv.env['TMDB_API_KEY'] ?? '';

  static String get apiToken => dotenv.env['TMDB_READ_TOKEN'] ?? '';

  static const String topRatedMovies = "movie/top_rated";
  static const String topRatedTvSeries = "tv/top_rated";
  static const String trendingMedia = "trending/all/day";
  static const String movieDetails = "movie";
  static const String tvDetails = "tv";
  static const String multiSearch = "search/multi";
  static const String movieGenres = "genre/movie/list";
  static const String tvGenres = "genre/tv/list";
  static const String personDetails = "person";

  static const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";
  static const String videoCoverBaseUrl = 'https://img.youtube.com/vi/';

  static const String companyImageError =
      'https://imgs.search.brave.com/EJMCxyVRjJtDJDePd6-7kPazT9g-Q5_Xx5cUcKwVmhY/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMjE1/NjQ1MDcwMy92ZWN0/b3IvNDA0LXBhZ2Ut/bm90LWZvdW5kLWlj/b24uanBnP3M9NjEy/eDYxMiZ3PTAmaz0y/MCZjPTlwRVFrbTRt/Y0x1Zmdzb1BhRkRp/cEsxNE1OSkV3aV9Q/QVZ1ZDBkaTV6aDg9';
  static const String actorImageError =
      'https://imgs.search.brave.com/N3LKytRAQg6sZ4CgMQ3XO5VPDYph_hzPT2ywP8CeGzk/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzgzL2Jj/LzhiLzgzYmM4Yjg4/Y2Y2YmM0YjRlMDRk/MTUzYTQxOGNkZTYy/LmpwZw';
}