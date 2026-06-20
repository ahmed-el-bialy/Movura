import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Future<UserCredential> loginWithEmailAndPassword({
    required String email,

    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,

      password: password,
    );
  }

  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,

    required String password,
  }) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
      email: email,

      password: password,
    );
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateUserName({required String name}) async {
    await currentUser!.updateDisplayName(name);
  }

  Future<void> deleteAccount({
    required String email,

    required String password,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,

      password: password,
    );

    await currentUser!.reauthenticateWithCredential(credential);

    await currentUser!.delete();

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

    await currentUser!.reauthenticateWithCredential(credential);

    await currentUser!.updatePassword(newPassword);
  }
}