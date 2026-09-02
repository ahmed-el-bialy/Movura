import 'package:flutter_test/flutter_test.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/features/auth/data/models/user_model.dart';
import 'package:movura/features/library/data/repos/library_repo.dart';
import 'package:movura/features/library/logic/library_cubit.dart';

class FakeLibraryRepo implements LibraryRepo {
  UserModel? mockUserModel;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Stream<UserModel?> getLibraryStream() {
    return Stream.value(mockUserModel);
  }

  @override
  Future<void> toggleItem({
    required PosterModel poster,
    required String collectionName,
    required bool isAdding,
  }) async {}
}

void main() {
  group('LibraryCubit Tests', () {
    late FakeLibraryRepo fakeLibraryRepo;
    late LibraryCubit libraryCubit;

    setUp(() {
      fakeLibraryRepo = FakeLibraryRepo();
      libraryCubit = LibraryCubit(
        fakeLibraryRepo,
        authStateStream: const Stream.empty(),
      );
    });

    tearDown(() {
      libraryCubit.close();
    });

    test('isItemInCollection returns false when state has no userModel', () {
      final poster = PosterModel(id: 101, title: 'Inception');
      expect(libraryCubit.isItemInCollection(poster, 'favorites'), false);
    });

    test('isItemInCollection returns true when poster exists in favorites', () async {
      final poster = PosterModel(id: 101, title: 'Inception');
      fakeLibraryRepo.mockUserModel = UserModel(
        id: 'u1',
        name: 'Test User',
        email: 'user@test.com',
        favorites: [poster],
      );

      libraryCubit.listenToLibrary();

      await pumpEventQueue();

      expect(libraryCubit.isItemInCollection(poster, 'favorites'), true);
    });
  });
}
