import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/models/poster_model.dart';

import '../../data/repo/home_repo.dart';

part 'trending_content_state.dart';

class TrendingContentCubit extends Cubit<TrendingContentState> {
  TrendingContentCubit({required this.postersRepo})
    : super(TrendingContentInitial());

  final HomeRepo postersRepo;
  List<PosterModel>? posters;

  Future<void> getTrendingPosters() async {
    emit(TrendingContentLoading());
    try {
      posters = await postersRepo.getTrendingMedia();
      emit(TrendingContentLoaded(posters: posters ?? []));
    } catch (e) {
      emit(TrendingContentFailed(errorMessage: e.toString()));
    }
  }
}
