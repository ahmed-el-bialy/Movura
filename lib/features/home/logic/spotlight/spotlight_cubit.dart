import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/poster_model.dart';
import '../../data/repo/home_repo.dart';

part 'spotlight_state.dart';

class SpotlightCubit extends Cubit<SpotlightState> {
  SpotlightCubit({required this.postersRepo}) : super(SpotlightInitial());

  final HomeRepo postersRepo;
  List<PosterModel>? posters;

  Future<void> getSpotlightPosters() async {
    emit(SpotlightLoading());
    try {
      posters = await postersRepo.getTrendingWeekly();
      emit(SpotlightLoaded(posters: posters ?? []));
    } catch (e) {
      emit(SpotlightError(errorMessage: e.toString()));
    }
  }
}
