import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Future<UserCredential> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      return await firebaseAuth.signInWithProvider(GoogleAuthProvider());
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Firebase Auth error occurred.';
    } catch (e) {
      throw 'Google Sign-In failed: ${e.toString()}';
    }
  }

  Future<UserCredential?> signInWithApple() async {
    try {
      final AppleAuthProvider appleProvider = AppleAuthProvider();
      return await firebaseAuth.signInWithProvider(appleProvider);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveUserData({
    required Map<String, dynamic> userData,
    required String uid,
  }) async {
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .set(userData, SetOptions(merge: true));
    } catch (e) {
      throw 'Firestore Write Error: ${e.toString()}';
    }
  }

  Future<Map<String, dynamic>> getUserData({required String uid}) async {
    try {
      final doc = await firestore
          .collection('users')
          .doc(uid).get();
      return doc.data() ?? {};
    } catch (e) {
      return {};
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (_) {}
  }

  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateUserName({required String name}) async {
    await currentUser?.updateDisplayName(name);
  }

  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    await currentUser?.reauthenticateWithCredential(credential);
    await currentUser?.delete();
    await firebaseAuth.signOut();
  }

  Future<void> restPasswordFromCurrentPassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );

    await currentUser?.reauthenticateWithCredential(credential);
    await currentUser?.updatePassword(newPassword);
  }

  Future<void> deleteUserData({required String uid}) async {
    await firestore.collection('users').doc(uid).delete();
  }
}
