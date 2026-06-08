import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movura/core/utils/constants/api_constants.dart';
import 'package:movura/features/details_screen/data/repos/tv_repos/tv_reviews_repo.dart';

import '../../features/details_screen/data/repos/movie_repos/about_repo.dart';
import '../../features/details_screen/data/repos/movie_repos/reviews_repo.dart';
import '../../features/details_screen/data/repos/movie_repos/similar_repo.dart';
import '../../features/details_screen/data/repos/tv_repos/about_tv_series_repo.dart';
import '../../features/details_screen/data/repos/tv_repos/tv_similar_repo.dart';
import '../../features/details_screen/data/webs_services/movie_web_services.dart';
import '../../features/details_screen/data/webs_services/tv_web_services.dart';
import '../../features/home_screen/data/repo/top_rated_movies_repo.dart';
import '../../features/home_screen/data/repo/top_rated_tv_series.dart';
import '../../features/home_screen/data/repo/trending_content_repo.dart';
import '../../features/home_screen/data/web_services/home_web_services.dart';
import '../../features/home_screen/logic/top_rated_movie/top_rated_movie_cubit.dart';
import '../../features/home_screen/logic/tpo_rated_movies/top_rated_tv_series_cubit.dart';
import '../../features/home_screen/logic/trending_content/trending_content_cubit.dart';
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

  sl.registerLazySingleton<TrendingContentRepo>(
        () => TrendingContentRepo(sl<HomeWebServices>()),
  );

  sl.registerLazySingleton<AboutRepo>(() => AboutRepo(sl<MovieWebServices>()));

  sl.registerLazySingleton<ReviewsRepo>(
        () => ReviewsRepo(detailsWebServices: sl<MovieWebServices>()),
  );

  sl.registerLazySingleton<SimilarRepo>(
        () => SimilarRepo(detailsWebServices: sl<MovieWebServices>()),
  );
  sl.registerLazySingleton<AboutTvSeriesRepo>(
        () => AboutTvSeriesRepo(sl<TvWebServices>()),
  );
  sl.registerLazySingleton<TvSimilarRepo>(
        () => TvSimilarRepo(detailsWebServices: sl<TvWebServices>()),
  );
  sl.registerLazySingleton<TvReviewsRepo>(
        () => TvReviewsRepo(detailsWebServices: sl<TvWebServices>()),
  );

  sl.registerLazySingleton<TopRatedMoviesRepo>(
        () => TopRatedMoviesRepo(webServices: sl<HomeWebServices>()),
  );

  sl.registerLazySingleton<TopRatedTvSeriesRepo>(
    () => TopRatedTvSeriesRepo(webServices: sl<HomeWebServices>()),
  );

  sl.registerFactory<TrendingContentCubit>(
        () => TrendingContentCubit(postersRepo: sl<TrendingContentRepo>()),
  );

  sl.registerFactory<TopRatedMovieCubit>(
        () => TopRatedMovieCubit(postersRepo: sl<TopRatedMoviesRepo>()),
  );

  sl.registerFactory<TopRatedTvSeriesCubit>(
    () => TopRatedTvSeriesCubit(postersRepo: sl<TopRatedTvSeriesRepo>()),
  );
}