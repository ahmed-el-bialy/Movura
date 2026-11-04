import 'package:movura/core/models/poster_model.dart';
import 'package:movura/features/auth/data/models/user_model.dart';
import '../web_services/library_services.dart';

class LibraryRepo {
  final LibraryServices libraryServices;

  LibraryRepo(this.libraryServices);

  Stream<UserModel?> getLibraryStream() {
    return libraryServices.getUserLibraryStream().map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return UserModel.fromJson(doc.data()!);
    });
  }

  Future<void> toggleItem({
    required PosterModel poster,
    required String collectionName,
    required bool isAdding,
  }) async {
    final mediaType = switch (poster.mediaType) {
      'movie' => 'movies',
      'tv' => 'tvSeries',
      _ => throw ArgumentError.value(
        poster.mediaType,
        'poster.mediaType',
        'Only movies and TV series can be added to the library.',
      ),
    };

    await libraryServices.toggleLibraryItem(
      posterJson: poster.toJson(),
      collectionName: collectionName,
      mediaType: mediaType,
      isAdding: isAdding,
    );
  }
}
