import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LibraryServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String? get currentUid => _firebaseAuth.currentUser?.uid;

  Stream<DocumentSnapshot<Map<String, dynamic>>>? getUserLibraryStream() {
    final uid = currentUid;
    if (uid == null) return null;
    return _firestore.collection('users').doc(uid).snapshots();
  }

  Future<void> toggleLibraryItem({
    required Map<String, dynamic> posterJson,
    required String collectionName,
    required bool isAdding,
  }) async {
    final uid = currentUid;
    if (uid == null) return;

    final docRef = _firestore.collection('users').doc(uid);

    if (isAdding) {
      await docRef.update({
        collectionName: FieldValue.arrayUnion([posterJson]),
      });
    } else {
      await docRef.update({
        collectionName: FieldValue.arrayRemove([posterJson]),
      });
    }
  }
}
