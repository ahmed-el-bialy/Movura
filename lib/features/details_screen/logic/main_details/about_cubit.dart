import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/features/details_screen/data/models/about_model.dart';
import 'package:movura/features/details_screen/data/repos/about_repo.dart';

part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit({required this.repo}) : super(AboutInitial());
  AboutModel? mainDetailsModel;

  final AboutRepo repo;

  Future<void> getMovieMainDetails({required int id}) async {
    emit(AboutLoading());
    try {
      mainDetailsModel = await repo.getMovieMainDetails(movieId: id);
      emit(AboutSuccess(model: mainDetailsModel!));
    } catch (e) {
      emit(AboutFailed(errorMessage: e.toString()));
    }
  }
}
