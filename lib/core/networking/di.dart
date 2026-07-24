import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/features/search/data/repo/search_repo.dart';
import 'package:movura/features/search/data/web_services/search_web_services.dart';

import '../../features/details/data/repos/movies_repo.dart';
import '../../features/details/data/repos/tv_series_repo.dart';
import '../../features/details/data/webs_services/movie_web_services.dart';
import '../../features/details/data/webs_services/tv_web_services.dart';
import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/data/web_services/auth_services.dart';
import '../../features/auth/logic/auth/auth_cubit.dart';
import '../../features/details/logic/movie_screen_cubit/main_details/about_cubit.dart';
import '../../features/details/logic/movie_screen_cubit/reviews/reviews_cubit.dart';
import '../../features/details/logic/movie_screen_cubit/similar_content/similar_content_cubit.dart';
import '../../features/details/logic/tv_series_cubit/about_tv/about_tv_cubit.dart';
import '../../features/details/logic/tv_series_cubit/reviews/reviews_cubit.dart';
import '../../features/details/logic/tv_series_cubit/similar_content/similar_content_cubit.dart';
import '../../features/details/logic/tv_series_cubit/tv_episode_details_cubit/tv_episode_details_cubit.dart';
import '../../features/details/logic/tv_series_cubit/tv_seasons_cubit/tv_seasons_cubit.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../../features/home/data/web_services/home_web_services.dart';
import '../../features/home/logic/top_rated_movies/top_rated_movies_cubit.dart';
import '../../features/home/logic/tpo_rated_tv_series/top_rated_tv_series_cubit.dart';
import '../../features/home/logic/trending_content/trending_content_cubit.dart';
import '../../features/search/logic/search/search_cubit.dart';
import 'dio_factory.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  final dio = DioFactory.getDio();
  sl.registerLazySingleton<Dio>(() => dio);

  // ==========================================
  // 2. Web Services (API Clients)
  // ==========================================
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

  sl.registerLazySingleton<AuthServices>(() => AuthServices());

  // ==========================================
  // 3. Repositories
  // ==========================================

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

  sl.registerLazySingleton<AuthRepo>(() => AuthRepo(sl<AuthServices>()));

  // ==========================================
  // 4. Cubits (State Management) - Factories
  // ==========================================

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

  sl.registerFactory<AboutCubit>(
    () => AboutCubit(repo: sl<MovieRepo>()),
  );

  sl.registerFactory<ReviewsCubit>(
    () => ReviewsCubit(repo: sl<MovieRepo>()),
  );

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
}
