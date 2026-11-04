import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LibraryServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String? get currentUid => _firebaseAuth.currentUser?.uid;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserLibraryStream() {
    final uid = currentUid;
    if (uid == null) return const Stream.empty();
    return _firestore.collection('users').doc(uid).snapshots();
  }

  Future<void> toggleLibraryItem({
    required Map<String, dynamic> posterJson,
    required String collectionName,
    required String mediaType,
    required bool isAdding,
  }) async {
    final uid = currentUid;
    if (uid == null) return;

    if (!const {
      'favorites',
      'toWatch',
      'watched',
      'watchNow',
    }.contains(collectionName)) {
      throw ArgumentError.value(collectionName, 'collectionName');
    }
    if (!const {'movies', 'tvSeries'}.contains(mediaType)) {
      throw ArgumentError.value(mediaType, 'mediaType');
    }

    final docRef = _firestore.collection('users').doc(uid);
    final itemId = posterJson['id']?.toString();
    if (itemId == null || itemId.isEmpty) return;

    final fieldPath = FieldPath(['library', collectionName, mediaType, itemId]);

    if (isAdding) {
      await docRef.set({
        'schemaVersion': 2,
        'library': {
          collectionName: {
            mediaType: {itemId: posterJson},
          },
        },
      }, SetOptions(merge: true));
    } else {
      try {
        await docRef.update({fieldPath: FieldValue.delete()});
      } catch (e) {
        if (e is FirebaseException && e.code == 'not-found') {
          return;
        }
        rethrow;
      }
    }
  }
}
