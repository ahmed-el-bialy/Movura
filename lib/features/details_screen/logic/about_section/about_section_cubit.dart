import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movura/features/details_screen/data/models/about_model.dart';
import 'package:movura/features/details_screen/data/repos/about_section_repo.dart';

part 'about_section_state.dart';

class AboutSectionCubit extends Cubit<AboutSectionState> {
  AboutSectionCubit({required this.repo}) : super(AboutSectionInitial());
  AboutModel? aboutModel;

  final AboutSectionRepo repo;

  Future<void> getAboutSectionData({required int id}) async {
    emit(AboutSectionLoading());
    try {
      aboutModel = await repo.getMovieMainDetails(movieId: id);
      emit(AboutSectionLoaded(model: aboutModel!));
    } catch (e) {
      emit(AboutSectionFailed(errorMessage: e.toString()));
    }
  }
}
