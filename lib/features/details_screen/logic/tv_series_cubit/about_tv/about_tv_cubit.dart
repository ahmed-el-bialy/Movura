import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/tv_models/about_tv_series_model.dart';
import '../../../data/repos/tv_repos/about_tv_series_repo.dart';

part 'about_tv_state.dart';

class AboutTvCubit extends Cubit<AboutTvState> {
  AboutTvCubit({required this.repo}) : super(AboutTvInitial());
  AboutTvSeriesModel? mainDetailsModel;

  final AboutTvSeriesRepo repo;

  Future<void> getMovieMainDetails({required int id}) async {
    emit(AboutLoading());
    try {
      mainDetailsModel = await repo.getTvSeriesMainDetails(movieId: id);
      emit(AboutTvLoaded(model: mainDetailsModel!));
    } catch (e) {
      emit(AboutTvFailed(errorMessage: e.toString()));
    }
  }
}
