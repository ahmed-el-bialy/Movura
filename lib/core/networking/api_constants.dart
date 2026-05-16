import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final String baseUrl = dotenv.env['BASE_URL'] ?? 'Default_URL';
  static final String apiKey = dotenv.env['API_KEY'] ?? 'Default_Key';
  static final String apiToken = dotenv.env['API_TOKEN'] ?? 'Default_Token';

  static const String imageBaseUrl = "https://image.tmdb.org/t/p/";
  static const String trendingMedia = "trending/all/day";
}
