import 'package:dio/dio.dart';

import '../utils/constants/api_constants.dart';

class DioFactory {
  static Dio getDio() {
    final headers = {
      'Authorization': 'Bearer ${ApiConstants.apiToken}',
      'accept': 'application/json',
    };

    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 25),
        receiveTimeout: const Duration(seconds: 30),
        headers: headers,
        queryParameters: {'api_key': ApiConstants.apiKey},
      ),
    );

    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );

    return dio;
  }
}
