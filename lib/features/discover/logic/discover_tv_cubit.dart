import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/models/poster_model.dart';
import '../data/repo/discover_repo.dart';

abstract class DiscoverTvState {}

class DiscoverTvInitial extends DiscoverTvState {}
class DiscoverTvLoading extends DiscoverTvState {}
class DiscoverTvLoaded extends DiscoverTvState {
  final List<PosterModel> trendingToday;
  final List<PosterModel> trendingWeek;
  final List<PosterModel> onTheAir;
  final List<PosterModel> popular;
  final List<PosterModel> topRated;

  DiscoverTvLoaded({
    required this.trendingToday,
    required this.trendingWeek,
    required this.onTheAir,
    required this.popular,
    required this.topRated,
  });
}
class DiscoverTvError extends DiscoverTvState {
  final String message;
  DiscoverTvError(this.message);
}

class DiscoverTvCubit extends Cubit<DiscoverTvState> {
  final DiscoverRepo _repo;
  DiscoverTvCubit(this._repo) : super(DiscoverTvInitial());

  Future<void> getDiscoverTv() async {
    emit(DiscoverTvLoading());
    try {
      final results = await Future.wait([
        _repo.getTrendingTv("day"),
        _repo.getTrendingTv("week"),
        _repo.getTvByCategory("on_the_air"),
        _repo.getTvByCategory("popular"),
        _repo.getTvByCategory("top_rated"),
      ]);

      emit(DiscoverTvLoaded(
        trendingToday: results[0],
        trendingWeek: results[1],
        onTheAir: results[2],
        popular: results[3],
        topRated: results[4],
      ));
    } catch (e) {
      emit(DiscoverTvError(e.toString()));
    }
  }
}
