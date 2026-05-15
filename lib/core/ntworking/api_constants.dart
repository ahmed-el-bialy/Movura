import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final String baseUrl = dotenv.env['BASE_URL'] ?? 'Default_URL';
  static final String apiKey = dotenv.env['API_KEY'] ?? 'Default_Key';
  static const String imageBaseUrl = "https://image.tmdb.org/t/p";
}
