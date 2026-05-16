import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movura/core/networking/api_constants.dart';
import 'package:movura/features/home_screen/data/web_services/web_services.dart';

import '../../features/home_screen/data/repo/posters_repo.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  final String appBaseUrl = ApiConstants.baseUrl;
  final String apiKey = ApiConstants.apiKey;
  final String apiToken = ApiConstants.apiToken;
  var headers = {
    'Authorization': 'Bearer $apiToken',
    'accept': 'application/json',
  };

  final dio = Dio(
    BaseOptions(
      baseUrl: appBaseUrl,
      connectTimeout: const Duration(seconds: 22),
      receiveTimeout: const Duration(seconds: 22),
      headers: headers,
      queryParameters: {'api_key': apiKey},
    ),
  );

  sl.registerLazySingleton<Dio>(() => dio);

  sl.registerLazySingleton<WebServices>(
    () => WebServices(sl<Dio>(), baseUrl: appBaseUrl),
  );
  sl.registerLazySingleton<PostersRepo>(() => PostersRepo(sl<WebServices>()));
}
