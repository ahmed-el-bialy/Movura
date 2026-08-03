import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/models/poster_model.dart';
import '../data/repo/discover_repo.dart';

abstract class DiscoverPeopleState {}

class DiscoverPeopleInitial extends DiscoverPeopleState {}
class DiscoverPeopleLoading extends DiscoverPeopleState {}
class DiscoverPeopleLoaded extends DiscoverPeopleState {
  final List<PosterModel> popular;
  final List<PosterModel> trendingDay;

  DiscoverPeopleLoaded({
    required this.popular,
    required this.trendingDay,
  });
}
class DiscoverPeopleError extends DiscoverPeopleState {
  final String message;
  DiscoverPeopleError(this.message);
}

class DiscoverPeopleCubit extends Cubit<DiscoverPeopleState> {
  final DiscoverRepo _repo;
  DiscoverPeopleCubit(this._repo) : super(DiscoverPeopleInitial());

  Future<void> getDiscoverPeople() async {
    emit(DiscoverPeopleLoading());
    try {
      final results = await Future.wait([
        _repo.getPopularPeople(),
        _repo.getTrendingPeople("day"),
      ]);

      emit(DiscoverPeopleLoaded(
        popular: results[0],
        trendingDay: results[1],
      ));
    } catch (e) {
      emit(DiscoverPeopleError(e.toString()));
    }
  }
}
