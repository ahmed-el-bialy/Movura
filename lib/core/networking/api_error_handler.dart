import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "Connection timeout. Please check your internet connection.";
        case DioExceptionType.sendTimeout:
          return "Send timeout in connection with server.";
        case DioExceptionType.receiveTimeout:
          return "Receive timeout in connection with server.";
        case DioExceptionType.badCertificate:
          return "Bad certificate in connection with server.";
        case DioExceptionType.badResponse:
          return _handleBadResponse(error.response);
        case DioExceptionType.cancel:
          return "Request to server was cancelled.";
        case DioExceptionType.connectionError:
          return "No internet connection. Please try again.";
        case DioExceptionType.unknown:
        default:
          return "Unexpected error occurred. Please try again.";
      }
    } else if (error is String) {
      return error;
    } else {
      return error?.toString() ?? "An unknown error occurred.";
    }
  }

  static String _handleBadResponse(Response? response) {
    if (response == null) return "Server error occurred.";

    final statusCode = response.statusCode;
    final data = response.data;

    if (data is Map<String, dynamic> && data.containsKey('status_message')) {
      return data['status_message'].toString();
    }

    switch (statusCode) {
      case 400:
        return "Bad request. Please try again.";
      case 401:
        return "Unauthorized. Invalid API key or token.";
      case 403:
        return "Forbidden access.";
      case 404:
        return "Resource not found.";
      case 422:
        return "Unprocessable entity.";
      case 500:
        return "Internal server error. Please try again later.";
      case 503:
        return "Service unavailable. Please try again later.";
      default:
        return "Server error ($statusCode). Please try again.";
    }
  }
}
