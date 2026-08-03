import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/data/web_services/auth_services.dart';
import '../../features/auth/logic/auth/auth_cubit.dart';
import '../../features/discover/data/repo/discover_repo.dart';
import '../../features/discover/logic/discover_movies_cubit.dart';
import '../../features/discover/logic/discover_people_cubit.dart';
import '../../features/discover/logic/discover_tv_cubit.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../../features/home/data/web_services/home_web_services.dart';
import '../../features/home/logic/top_rated_movies/top_rated_movies_cubit.dart';
import '../../features/home/logic/top_rated_tv_series/top_rated_tv_series_cubit.dart';
import '../../features/home/logic/trending_content/trending_content_cubit.dart';
import '../../features/movie_details/data/repos/movies_repo.dart';
import '../../features/movie_details/data/web_services/movie_web_services.dart';
import '../../features/movie_details/logic/about/about_cubit.dart';
import '../../features/movie_details/logic/reviews/reviews_cubit.dart';
import '../../features/movie_details/logic/similar_content/similar_content_cubit.dart';
import '../../features/person_details/data/repos/person_repo.dart';
import '../../features/person_details/data/web_services/person_web_services.dart';
import '../../features/person_details/logic/person_details_cubit.dart';
import '../../features/search/data/repo/search_repo.dart';
import '../../features/search/data/web_services/search_web_services.dart';
import '../../features/search/logic/search/search_cubit.dart';
import '../../features/see_all/data/repo/see_all_repo.dart';
import '../../features/see_all/data/web_services/see_all_web_services.dart';
import '../../features/see_all/logic/see_all_cubit.dart';
import '../../features/tv_details/data/repos/tv_series_repo.dart';
import '../../features/tv_details/data/web_services/tv_web_services.dart';
import '../../features/tv_details/logic/about/about_tv_cubit.dart';
import '../../features/tv_details/logic/episodes/tv_episode_details_cubit.dart';
import '../../features/tv_details/logic/reviews/reviews_cubit.dart';
import '../../features/tv_details/logic/seasons/tv_seasons_cubit.dart';
import '../../features/tv_details/logic/similar_content/similar_content_cubit.dart';
import '../constants/api_constants.dart';
import 'dio_factory.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  final dio = DioFactory.getDio();
  sl.registerLazySingleton<Dio>(() => dio);

  sl.registerLazySingleton<HomeWebServices>(
    () => HomeWebServices(sl<Dio>(), baseUrl: ApiConstants.baseUrl),
  );
  sl.registerLazySingleton<MovieWebServices>(
    () => MovieWebServices(sl<Dio>(), baseUrl: ApiConstants.baseUrl),
  );
  sl.registerLazySingleton<TvWebServices>(
    () => TvWebServices(sl<Dio>(), baseUrl: ApiConstants.baseUrl),
  );
  sl.registerLazySingleton<SearchWebServices>(
    () => SearchWebServices(sl<Dio>(), baseUrl: ApiConstants.baseUrl),
  );
  sl.registerLazySingleton<PersonWebServices>(
    () => PersonWebServices(sl<Dio>(), baseUrl: ApiConstants.baseUrl),
  );
  sl.registerLazySingleton<SeeAllWebServices>(
    () => SeeAllWebServices(sl<Dio>(), baseUrl: ApiConstants.baseUrl),
  );
  sl.registerLazySingleton<AuthServices>(() => AuthServices());

  sl.registerLazySingleton<HomeRepo>(
    () => HomeRepo(homeWebServices: sl<HomeWebServices>()),
  );
  sl.registerLazySingleton<MovieRepo>(
    () => MovieRepo(movieWebServices: sl<MovieWebServices>()),
  );
  sl.registerLazySingleton<TvSeriesRepo>(
    () => TvSeriesRepo(tvWebServices: sl<TvWebServices>()),
  );
  sl.registerLazySingleton<SearchRepo>(
    () => SearchRepo(searchWebServices: sl<SearchWebServices>()),
  );
  sl.registerLazySingleton<PersonRepo>(
    () => PersonRepo(personWebServices: sl<PersonWebServices>()),
  );
  sl.registerLazySingleton<SeeAllRepo>(
    () => SeeAllRepo(webServices: sl<SeeAllWebServices>()),
  );
  sl.registerLazySingleton<DiscoverRepo>(
    () => DiscoverRepo(webServices: sl<SeeAllWebServices>()),
  );
  sl.registerLazySingleton<AuthRepo>(() => AuthRepo(sl<AuthServices>()));

  _initCubits();
}

void _initCubits() {
  sl.registerFactory<TrendingContentCubit>(
    () => TrendingContentCubit(postersRepo: sl<HomeRepo>()),
  );
  sl.registerFactory<TopRatedMovieCubit>(
    () => TopRatedMovieCubit(postersRepo: sl<HomeRepo>()),
  );
  sl.registerFactory<TopRatedTvSeriesCubit>(
    () => TopRatedTvSeriesCubit(postersRepo: sl<HomeRepo>()),
  );
  sl.registerFactory<SearchCubit>(
    () => SearchCubit(searchRepo: sl<SearchRepo>(), homeRepo: sl<HomeRepo>()),
  );
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl<AuthRepo>()));
  sl.registerFactory<AboutCubit>(() => AboutCubit(repo: sl<MovieRepo>()));
  sl.registerFactory<ReviewsCubit>(() => ReviewsCubit(repo: sl<MovieRepo>()));
  sl.registerFactory<SimilarContentCubit>(
    () => SimilarContentCubit(repo: sl<MovieRepo>()),
  );
  sl.registerFactory<AboutTvCubit>(
    () => AboutTvCubit(repo: sl<TvSeriesRepo>()),
  );
  sl.registerFactory<TvSeriesReviewsCubit>(
    () => TvSeriesReviewsCubit(repo: sl<TvSeriesRepo>()),
  );
  sl.registerFactory<TvSeriesSimilarContentCubit>(
    () => TvSeriesSimilarContentCubit(repo: sl<TvSeriesRepo>()),
  );
  sl.registerFactory<TvEpisodeDetailsCubit>(
    () => TvEpisodeDetailsCubit(repo: sl<TvSeriesRepo>()),
  );
  sl.registerFactory<TvSeasonsCubit>(
    () => TvSeasonsCubit(repo: sl<TvSeriesRepo>()),
  );
  sl.registerFactory<PersonDetailsCubit>(
    () => PersonDetailsCubit(repo: sl<PersonRepo>()),
  );
  sl.registerFactory<SeeAllCubit>(() => SeeAllCubit(sl<SeeAllRepo>()));
  sl.registerFactory<DiscoverMoviesCubit>(
    () => DiscoverMoviesCubit(sl<DiscoverRepo>()),
  );
  sl.registerFactory<DiscoverTvCubit>(
    () => DiscoverTvCubit(sl<DiscoverRepo>()),
  );
  sl.registerFactory<DiscoverPeopleCubit>(
    () => DiscoverPeopleCubit(sl<DiscoverRepo>()),
  );
}
