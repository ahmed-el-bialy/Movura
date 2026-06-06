import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movura/core/utils/constants/api_constants.dart';

import '../../features/details_screen/data/repos/movie_repos/about_repo.dart';
import '../../features/details_screen/data/repos/movie_repos/reviews_repo.dart';
import '../../features/details_screen/data/repos/movie_repos/similar_repo.dart';
import '../../features/details_screen/data/repos/tv_repos/about_tv_series_repo.dart';
import '../../features/details_screen/data/webs_services/movie_web_services.dart';
import '../../features/details_screen/data/webs_services/tv_web_services.dart';
import '../../features/home_screen/data/repo/posters_repo.dart';
import '../../features/home_screen/data/web_services/trending_web_services.dart';
import 'dio_factory.dart';

final sl = GetIt.instance;

Future<void> initDI() async {

  final dio = DioFactory.getDio();
  sl.registerLazySingleton<Dio>(() => dio);

  sl.registerLazySingleton<TrendingWebServices>(
        () => TrendingWebServices(sl<Dio>(), baseUrl: ApiConstants.baseUrl),
  );

  sl.registerLazySingleton<MovieWebServices>(
        () => MovieWebServices(sl<Dio>(), baseUrl: ApiConstants.baseUrl),
  );

  sl.registerLazySingleton<TvWebServices>(
        () => TvWebServices(sl<Dio>(), baseUrl: ApiConstants.baseUrl),
  );

  sl.registerLazySingleton<PostersRepo>(
        () => PostersRepo(sl<TrendingWebServices>()),
  );

  sl.registerLazySingleton<AboutRepo>(() => AboutRepo(sl<MovieWebServices>()),
  );

  sl.registerLazySingleton<ReviewsRepo>(
        () => ReviewsRepo(detailsWebServices: sl<MovieWebServices>()),
  );

  sl.registerLazySingleton<SimilarRepo>(
        () => SimilarRepo(detailsWebServices: sl<MovieWebServices>()),
  );
  sl.registerLazySingleton<AboutTvSeriesRepo>(
        () => AboutTvSeriesRepo(sl<TvWebServices>()),
  );
}