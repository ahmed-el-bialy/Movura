import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/features/home_screen/data/model/poster_model.dart';
import 'package:movura/features/home_screen/data/repo/posters_repo.dart';

part 'main_content_state.dart';

class MainContentCubit extends Cubit<MainContentState> {
  final PostersRepo postersRepo;
  late List<PosterModel> posters;

  MainContentCubit({required this.postersRepo}) : super(MainContentInitial());

  List<PosterModel> posterModel() {
    postersRepo.getTrendingMedia().then((poster) {
      emit(MainContentLoaded(posters: poster));
      posters = poster;
    });

    return posters;
  }
}
