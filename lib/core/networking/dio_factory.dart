import 'package:dio/dio.dart';
import 'package:movura/core/constants/api_constants.dart';

class DioFactory {
  static Dio getDio() {
    final headers = {
      'Authorization': 'Bearer ${ApiConstants.apiToken}',
      'accept': 'application/json',
    };

    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: headers,
        queryParameters: {'api_key': ApiConstants.apiKey},
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: false,
      ),
    );

    return dio;
  }
}
