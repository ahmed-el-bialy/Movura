import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/features/details_screen/data/models/main_details_model.dart';
import 'package:movura/features/details_screen/data/repos/main_details_repo.dart';

part 'main_details_state.dart';

class MainDetailsCubit extends Cubit<MainDetailsState> {
  MainDetailsCubit({required this.repo}) : super(MainDetailsInitial());
  MainDetailsModel? mainDetailsModel;

  final MainDetailsRepo repo;

  Future<void> getMovieMainDetails({required int id}) async {
    emit(MainDetailsLoading());
    try {
      mainDetailsModel = await repo.getMovieMainDetails(movieId: id);
      emit(MainDetailsSuccess(model: mainDetailsModel!));
    } catch (e) {
      emit(MainDetailsFailed(errorMessage: e.toString()));
    }
  }
}
