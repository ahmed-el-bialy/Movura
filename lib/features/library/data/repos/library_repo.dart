import 'package:movura/core/models/poster_model.dart';
import 'package:movura/features/auth/data/models/user_model.dart';
import '../web_services/library_services.dart';

class LibraryRepo {
  final LibraryServices libraryServices;

  LibraryRepo(this.libraryServices);

  Stream<UserModel?> getLibraryStream() {
    final stream = libraryServices.getUserLibraryStream();
    if (stream == null) return Stream.value(null);

    return stream.map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return UserModel.fromJson(doc.data()!);
    });
  }

  Future<void> toggleItem({
    required PosterModel poster,
    required String collectionName,
    required bool isAdding,
  }) async {
    await libraryServices.toggleLibraryItem(
      posterJson: poster.toJson(),
      collectionName: collectionName,
      isAdding: isAdding,
    );
  }
}
