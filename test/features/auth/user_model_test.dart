import 'package:flutter_test/flutter_test.dart';
import 'package:movura/features/auth/data/models/user_model.dart';

void main() {
  group('UserModel Firestore schema', () {
    test('reads movies and TV series from the nested library map', () {
      final user = UserModel.fromJson({
        'schemaVersion': 2,
        'profile': {
          'id': 'user-1',
          'email': 'user@example.com',
          'name': 'Movura User',
        },
        'library': {
          'favorites': {
            'movies': {
              '1': {'id': 1, 'title': 'Inception', 'media_type': 'movie'},
            },
            'tvSeries': {
              '2': {'id': 2, 'name': 'Dark', 'media_type': 'tv'},
            },
          },
          'toWatch': {'movies': {}, 'tvSeries': {}},
          'watched': {'movies': {}, 'tvSeries': {}},
          'watchNow': {'movies': {}, 'tvSeries': {}},
        },
      });

      expect(user.id, 'user-1');
      expect(user.favorites, hasLength(2));
      expect(user.favorites!.map((poster) => poster.id), containsAll([1, 2]));
    });

    test('continues to read the legacy collection maps', () {
      final user = UserModel.fromJson({
        'id': 'legacy-user',
        'email': 'legacy@example.com',
        'name': 'Legacy User',
        'favorites': {
          '7': {'id': 7, 'title': 'Legacy Movie', 'media_type': 'movie'},
        },
      });

      expect(user.favorites!.single.id, 7);
    });
  });
}
