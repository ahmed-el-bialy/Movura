import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/about_model.dart';
import '../../data/repos/movies_repo.dart';

part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit({required this.repo}) : super(AboutInitial());
  AboutModel? mainDetailsModel;

  final MovieRepo repo;

  Future<void> getMovieMainDetails({required int id}) async {
    emit(AboutLoading());
    try {
      mainDetailsModel = await repo.getMovieMainDetails(movieId: id);
      emit(AboutLoaded(model: mainDetailsModel!));
    } catch (e) {
      emit(AboutError(errorMessage: e.toString()));
    }
  }
}
