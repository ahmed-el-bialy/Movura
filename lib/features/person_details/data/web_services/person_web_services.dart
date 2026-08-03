import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/constants/api_constants.dart';
import '../person_details_model.dart';

part 'person_web_services.g.dart';

@RestApi()
abstract class PersonWebServices {
  factory PersonWebServices(Dio dio, {String? baseUrl}) = _PersonWebServices;

  @GET("${ApiConstants.personDetails}/{id}")
  Future<PersonDetailsModel> getPersonDetails({
    @Path("id") required int id,
    @Query("append_to_response")
    String additionalData = "movie_credits,tv_credits",
    @Query("language") String language = "en-US",
  });
}
