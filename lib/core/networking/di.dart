import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movura/core/networking/api_constants.dart';
import 'package:movura/features/details_screen/data/repos/about_section_repo.dart';
import 'package:movura/features/details_screen/data/webs_services/about_section_services.dart';
import 'package:movura/features/home_screen/data/web_services/web_services.dart';

import '../../features/details_screen/data/repos/main_details_repo.dart';
import '../../features/details_screen/data/webs_services/main_details_services.dart';
import '../../features/home_screen/data/repo/posters_repo.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  var headers = {
    'Authorization': 'Bearer ${ApiConstants.apiToken}',
    'accept': 'application/json',
  };

  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 25),
      receiveTimeout: const Duration(seconds: 2252),
      headers: headers,
      queryParameters: {'api_key': ApiConstants.apiKey},
    ),
  );

  sl.registerLazySingleton<Dio>(() => dio);

  sl.registerLazySingleton<WebServices>(
    () => WebServices(sl<Dio>(), baseUrl: ApiConstants.baseUrl),
  );
  sl.registerLazySingleton<PostersRepo>(() => PostersRepo(sl<WebServices>()));

  sl.registerLazySingleton<MainDetailsServices>(
    () => MainDetailsServices(sl<Dio>()),
  );

  sl.registerLazySingleton<MainDetailsRepo>(
    () => MainDetailsRepo(sl<MainDetailsServices>()),
  );

  sl.registerLazySingleton<AboutSectionServices>(
        () => AboutSectionServices(sl<Dio>()),
  );

  sl.registerLazySingleton<AboutSectionRepo>(
        () =>
        AboutSectionRepo(aboutSectionServices: sl<AboutSectionServices>(),),
  );
}
