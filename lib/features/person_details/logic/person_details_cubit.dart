import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/person_details_model.dart';
import '../data/repos/person_repo.dart';

part 'person_details_state.dart';

class PersonDetailsCubit extends Cubit<PersonDetailsState> {
  PersonDetailsCubit({required this.repo}) : super(PersonDetailsInitial());

  final PersonRepo repo;

  Future<void> getPersonDetails({required int id}) async {
    emit(PersonDetailsLoading());
    try {
      final personDetails = await repo.getPersonDetails(id: id);
      emit(PersonDetailsLoaded(personDetails: personDetails));
    } catch (e) {
      emit(PersonDetailsError(errorMessage: e.toString()));
    }
  }
}
