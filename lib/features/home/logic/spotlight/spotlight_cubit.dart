import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/poster_model.dart';
import '../../data/repo/home_repo.dart';

part 'spotlight_state.dart';

/// Drives the Hero Spotlight carousel using TMDB's weekly trending endpoint —
/// kept separate from the daily "Trending Now" section so both lists are
/// distinct and complementary.
class SpotlightCubit extends Cubit<SpotlightState> {
  SpotlightCubit({required this.homeRepo}) : super(SpotlightInitial());

  final HomeRepo homeRepo;

  Future<void> loadSpotlight() async {
    if (state is SpotlightLoaded) return;
    emit(SpotlightLoading());
    try {
      final posters = await homeRepo.getTrendingWeekly();
      emit(SpotlightLoaded(posters: posters));
    } catch (e) {
      emit(SpotlightError(message: e.toString()));
    }
  }
}
