import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/features/auth/data/repos/auth_repo.dart';
import 'package:movura/features/auth/data/web_services/auth_services.dart';
import 'package:movura/features/auth/logic/auth/auth_cubit.dart';
import 'package:movura/features/home/data/repo/home_repo.dart';
import 'package:movura/features/home/data/web_services/home_web_services.dart';
import 'package:movura/features/home/logic/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movura/features/home/logic/tpo_rated_tv_series/top_rated_tv_series_cubit.dart';
import 'package:movura/features/home/logic/trending_content/trending_content_cubit.dart';
import 'package:movura/features/movie_details/data/repos/movies_repo.dart';
import 'package:movura/features/movie_details/data/web_services/movie_web_services.dart';
import 'package:movura/features/movie_details/logic/main_details/about_cubit.dart';
import 'package:movura/features/movie_details/logic/reviews/reviews_cubit.dart';
import 'package:movura/features/movie_details/logic/similar_content/similar_content_cubit.dart';
import 'package:movura/features/person_details/data/repos/person_repo.dart';
import 'package:movura/features/person_details/data/web_services/person_web_services.dart';
import 'package:movura/features/person_details/logic/person_details_cubit.dart';
import 'package:movura/features/search/data/repo/search_repo.dart';
import 'package:movura/features/search/data/web_services/search_web_services.dart';
import 'package:movura/features/search/logic/search/search_cubit.dart';
import 'package:movura/features/tv_details/data/repos/tv_series_repo.dart';
import 'package:movura/features/tv_details/data/web_services/tv_web_services.dart';
import 'package:movura/features/tv_details/logic/about_tv/about_tv_cubit.dart';
import 'package:movura/features/tv_details/logic/reviews/reviews_cubit.dart';
import 'package:movura/features/tv_details/logic/similar_content/similar_content_cubit.dart';
import 'package:movura/features/tv_details/logic/tv_episode_details_cubit/tv_episode_details_cubit.dart';
import 'package:movura/features/tv_details/logic/tv_seasons_cubit/tv_seasons_cubit.dart';

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
}
