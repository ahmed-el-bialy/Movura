import 'package:dio/dio.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/utils/constants/api_constants.dart';

part 'search_web_services.g.dart';

@RestApi()
abstract class SearchWebServices {
  factory SearchWebServices(Dio dio, {String? baseUrl}) = _SearchWebServices;

  @GET(ApiConstants.multiSearch)
  Future<PosterResponse> getSearchResults({
    @Query("language") String language = "en-US",
    @Query("query") required String query,
    @Query("page") int? page=1,
  });
}