import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/features/details/data/models/tv_models/episode_details_model.dart';
import 'package:movura/features/details/data/repos/tv_series_repo.dart';

part 'tv_episode_details_state.dart';

class TvEpisodeDetailsCubit extends Cubit<TvEpisodeDetailsState> {
  TvEpisodeDetailsCubit({required this.repo})
      : super(TvEpisodeDetailsInitial());

  final TvSeriesRepo repo;
  EpisodeDetailsModel? episodeDetails;

  Future<void> getTvEpisodeDetails({
    required int tvId,
    required int seasonNumber,
    required int episodeNumber,
  }) async {
    emit(TvEpisodeDetailsLoading());
    try {
      episodeDetails = await repo.getTvEpisodeDetails(
        id: tvId,
        seasonNumber: seasonNumber,
        episodeNumber: episodeNumber,
      );
      emit(TvEpisodeDetailsLoaded(episodeDetails: episodeDetails!));
    } catch (e) {
      emit(TvEpisodeDetailsFailed(errorMessage: e.toString()));
    }
  }
}
