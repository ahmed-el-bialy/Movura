import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/season_details_model.dart';
import '../../data/repos/tv_series_repo.dart';

part 'tv_seasons_state.dart';

class TvSeasonsCubit extends Cubit<TvSeasonsState> {
  TvSeasonsCubit({required this.repo}) : super(TvSeasonsInitial());

  SeasonDetailsModel? seasonDetails;
  final TvSeriesRepo repo;

  Future<void> getTvSeasonDetails({
    required int tvId,
    required int seasonNumber,
  }) async {
    emit(TvSeasonsLoading());
    try {
      seasonDetails = await repo.getTvSeasonDetails(
        id: tvId,
        seasonNumber: seasonNumber,
      );
      emit(TvSeasonsLoaded(seasonDetails: seasonDetails!));
    } catch (e) {
      emit(TvSeasonsError(errorMessage: e.toString()));
    }
  }
}

