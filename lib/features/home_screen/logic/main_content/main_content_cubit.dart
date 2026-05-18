import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/features/home_screen/data/model/poster_model.dart';
import 'package:movura/features/home_screen/data/repo/posters_repo.dart';

part 'main_content_state.dart';

class MainContentCubit extends Cubit<MainContentState> {
  MainContentCubit({required this.postersRepo}) : super(MainContentInitial());

  final PostersRepo postersRepo;
  List<PosterModel>? posters;

  Future<void> getTrendingPosters() async {
    emit(MainContentLoading());
    try {
      posters = await postersRepo.getTrendingMedia();
      emit(MainContentLoaded(posters: posters ?? []));
    } catch (e) {
      emit(MainContentFailed(errorMessage: e.toString()));
    }
  }
}
