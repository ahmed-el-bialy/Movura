import '../person_details_model.dart';
import '../web_services/person_web_services.dart';

class PersonRepo {
  final PersonWebServices personWebServices;

  PersonRepo({required this.personWebServices});

  Future<PersonDetailsModel> getPersonDetails({required int id}) async {
    return await personWebServices.getPersonDetails(id: id);
  }
}
