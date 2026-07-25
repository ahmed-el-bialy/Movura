import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/about_tv_series_model.dart';
import '../../data/repos/tv_series_repo.dart';

part 'about_tv_state.dart';

class AboutTvCubit extends Cubit<AboutTvState> {
  AboutTvCubit({required this.repo}) : super(AboutTvInitial());
  AboutTvSeriesModel? mainDetailsModel;

  final TvSeriesRepo repo;

  Future<void> getTvSeriesMainDetails({required int id}) async {
    emit(AboutTvLoading());
    try {
      mainDetailsModel = await repo.getTvSeriesMainDetails(movieId: id);
      emit(AboutTvLoaded(model: mainDetailsModel!));
    } catch (e) {
      emit(AboutTvError(errorMessage: e.toString()));
    }
  }
}
