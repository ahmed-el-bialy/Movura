import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movura/core/utils/constants/api_constants.dart';
import 'package:movura/features/home_screen/data/web_services/web_services.dart';

import '../../features/details_screen/data/repos/about_repo.dart';
import '../../features/details_screen/data/webs_services/about_services.dart';
import '../../features/home_screen/data/repo/posters_repo.dart';
import 'dio_factory.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  final dio = DioFactory.getDio();
  sl.registerLazySingleton<Dio>(() => dio);

  sl.registerLazySingleton<WebServices>(
    () => WebServices(sl<Dio>(), baseUrl: ApiConstants.baseUrl),
  );
  sl.registerLazySingleton<PostersRepo>(() => PostersRepo(sl<WebServices>()));

  sl.registerLazySingleton<AboutServices>(() => AboutServices(sl<Dio>()));
  sl.registerLazySingleton<AboutRepo>(() => AboutRepo(sl<AboutServices>()));
}