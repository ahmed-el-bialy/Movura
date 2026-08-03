import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movura/core/models/poster_model.dart';
import '../data/models/see_all_arguments.dart';
import '../data/repo/see_all_repo.dart';

abstract class SeeAllState {}

class SeeAllInitial extends SeeAllState {}

class SeeAllLoading extends SeeAllState {}

class SeeAllLoaded extends SeeAllState {
  final List<PosterModel> items;
  final bool isFetchingMore;
  final bool hasReachedMax;

  SeeAllLoaded(
    this.items, {
    this.isFetchingMore = false,
    this.hasReachedMax = false,
  });
}

class SeeAllError extends SeeAllState {
  final String message;

  SeeAllError(this.message);
}

class SeeAllCubit extends Cubit<SeeAllState> {
  final SeeAllRepo _repo;

  SeeAllCubit(this._repo) : super(SeeAllInitial());

  int _currentPage = 1;
  bool _isFetchingMore = false;
  bool _hasReachedMax = false;
  List<PosterModel> _items = [];
  late SeeAllArguments _arguments;

  void init(SeeAllArguments arguments) {
    _arguments = arguments;
    _currentPage = 1;
    _hasReachedMax = false;
    _isFetchingMore = false;
    _items = [];
    emit(SeeAllLoading());
    _fetchPage();
  }

  void loadMore() {
    if (_isFetchingMore || _hasReachedMax) return;
    _currentPage++;
    _fetchPage();
  }

  Future<void> _fetchPage() async {
    if (_currentPage > 1) {
      _isFetchingMore = true;
      emit(
        SeeAllLoaded(
          _items,
          isFetchingMore: true,
          hasReachedMax: _hasReachedMax,
        ),
      );
    }

    try {
      final newItems = await _repo.getSeeAllData(
        endpoint: _arguments.endpoint,
        page: _currentPage,
        id: _arguments.id,
      );

      if (newItems.isEmpty) {
        _hasReachedMax = true;
      } else {
        _items.addAll(newItems);
      }

      _isFetchingMore = false;
      emit(
        SeeAllLoaded(
          _items,
          isFetchingMore: false,
          hasReachedMax: _hasReachedMax,
        ),
      );
    } catch (e) {
      _isFetchingMore = false;
      if (_currentPage == 1) {
        emit(SeeAllError(e.toString()));
      } else {
        emit(
          SeeAllLoaded(
            _items,
            isFetchingMore: false,
            hasReachedMax: _hasReachedMax,
          ),
        );
      }
    }
  }
}
