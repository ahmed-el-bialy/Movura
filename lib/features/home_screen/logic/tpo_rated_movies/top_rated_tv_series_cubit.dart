import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/poster_model.dart';
import '../../data/repo/top_rated_tv_series.dart';

part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesCubit extends Cubit<TopRatedTvSeriesState> {
  TopRatedTvSeriesCubit({required this.postersRepo})
    : super(TopRatedTvSeriesInitial());

  final TopRatedTvSeriesRepo postersRepo;
  List<PosterModel>? posters;

  Future<void> getTopRatedTvSeries() async {
    emit(TopRatedTvSeriesLoading());
    try {
      posters = await postersRepo.getTopRatedTvSeries();
      emit(TopRatedTvSeriesLoaded(posters: posters ?? []));
    } catch (e) {
      emit(TopRatedTvSeriesFailed(errorMessage: e.toString()));
    }
  }
}
