import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/models/poster_model.dart';
import '../../../core/networking/api_error_handler.dart';
import '../data/repos/library_repo.dart';
import 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  final LibraryRepo libraryRepo;
  StreamSubscription? _librarySubscription;
  StreamSubscription? _authSubscription;

  LibraryCubit(
    this.libraryRepo, {
    Stream<User?>? authStateStream,
  }) : super(LibraryInitial()) {
    final authStream =
        authStateStream ?? FirebaseAuth.instance.authStateChanges();
    _authSubscription = authStream.listen((user) {
      if (user != null) {
        listenToLibrary();
      } else {
        _librarySubscription?.cancel();
        emit(LibraryLoaded(null));
      }
    });

    if (FirebaseAuth.instance.currentUser != null) {
      listenToLibrary();
    }
  }

  void listenToLibrary() {
    emit(LibraryLoading());
    _librarySubscription?.cancel();
    _librarySubscription = libraryRepo.getLibraryStream().listen(
      (userModel) {
        emit(LibraryLoaded(userModel));
      },
      onError: (error) {
        emit(LibraryError(ApiErrorHandler.handle(error)));
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
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      emit(LibraryError("Please sign in to manage your library."));
      return;
    }

    try {
      final currentlyIn = isItemInCollection(poster, collectionName);
      await libraryRepo.toggleItem(
        poster: poster,
        collectionName: collectionName,
        isAdding: !currentlyIn,
      );
      // No need to emit success here, the stream listener handles it.
    } catch (e) {
      emit(LibraryError(ApiErrorHandler.handle(e)));
    }
  }

  @override
  Future<void> close() {
    _librarySubscription?.cancel();
    _authSubscription?.cancel();
    return super.close();
  }
}
