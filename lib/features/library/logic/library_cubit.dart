import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/models/poster_model.dart';
import '../data/repos/library_repo.dart';
import 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  final LibraryRepo libraryRepo;
  StreamSubscription? _librarySubscription;
  StreamSubscription? _authSubscription;

  LibraryCubit(this.libraryRepo) : super(LibraryInitial()) {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      listenToLibrary();
    });
    listenToLibrary();
  }

  void listenToLibrary() {
    emit(LibraryLoading());
    _librarySubscription?.cancel();
    _librarySubscription = libraryRepo.getLibraryStream().listen(
      (userModel) {
        emit(LibraryLoaded(userModel));
      },
      onError: (error) {
        emit(LibraryError(error.toString()));
      },
    );
  }

  bool isItemInCollection(PosterModel item, String collectionName) {
    final currentState = state;
    if (currentState is! LibraryLoaded || currentState.userModel == null) {
      return false;
    }

    final user = currentState.userModel!;
    List<PosterModel>? list;

    switch (collectionName) {
      case 'favorites':
        list = user.favorites;
        break;
      case 'toWatch':
        list = user.toWatch;
        break;
      case 'watched':
        list = user.watched;
        break;
      case 'watchNow':
        list = user.watchNow;
        break;
    }

    if (list == null) return false;
    return list.any((element) => element.id == item.id);
  }

  Future<void> toggleCollectionItem({
    required PosterModel poster,
    required String collectionName,
  }) async {
    final currentlyIn = isItemInCollection(poster, collectionName);
    await libraryRepo.toggleItem(
      poster: poster,
      collectionName: collectionName,
      isAdding: !currentlyIn,
    );
  }

  @override
  Future<void> close() {
    _librarySubscription?.cancel();
    _authSubscription?.cancel();
    return super.close();
  }
}
