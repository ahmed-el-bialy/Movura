import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/api_constants.dart';

class DioFactory {
  static Dio getDio() {
    final headers = {
      'Authorization': 'Bearer ${ApiConstants.apiToken}',
      'accept': 'application/json',
    };

    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: headers,
        queryParameters: {'api_key': ApiConstants.apiKey},
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: false,
        ),
      );
    }

    return dio;
  }
}
