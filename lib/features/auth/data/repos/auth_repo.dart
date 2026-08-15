import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import '../web_services/auth_services.dart';

class AuthRepo {
  final AuthServices authServices;

  AuthRepo(this.authServices);

  Future<UserModel> login(String email, String password) async {
    try {
      final credential = await authServices.loginWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userData = await authServices.getUserData(uid: credential.user!.uid);
      if (userData.isEmpty) {
        return UserModel(
          id: credential.user!.uid,
          email: email,
          name: credential.user!.displayName ?? "User",
        );
      }

      return UserModel.fromJson(userData);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await authServices.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      await authServices.updateUserName(name: name);

      final newUser = UserModel(
        id: credential.user!.uid,
        email: email,
        name: name,
        favorites: [],
        watched: [],
        toWatch: [],
        watchNow: [],
      );

      await authServices.saveUserData(
        userData: newUser.toJson(),
        uid: newUser.id,
      );

      return newUser;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      final credential = await authServices.signInWithGoogle();
      if (credential == null || credential.user == null) return null;

      final user = credential.user!;
      final userData = await authServices.getUserData(uid: user.uid);

      if (userData.isEmpty) {
        final newUser = UserModel(
          id: user.uid,
          email: user.email ?? "",
          name: user.displayName ?? "Google User",
          favorites: [],
          watched: [],
          toWatch: [],
          watchNow: [],
        );
        await authServices.saveUserData(
          userData: newUser.toJson(),
          uid: newUser.id,
        );
        return newUser;
      }

      return UserModel.fromJson(userData);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw "Google Sign-In failed. Please try again.";
    }
  }

  Future<UserModel?> signInWithApple() async {
    try {
      final credential = await authServices.signInWithApple();
      if (credential == null || credential.user == null) return null;

      final user = credential.user!;
      final userData = await authServices.getUserData(uid: user.uid);

      if (userData.isEmpty) {
        final newUser = UserModel(
          id: user.uid,
          email: user.email ?? "",
          name: user.displayName ?? "Apple User",
          favorites: [],
          watched: [],
          toWatch: [],
          watchNow: [],
        );
        await authServices.saveUserData(
          userData: newUser.toJson(),
          uid: newUser.id,
        );
        return newUser;
      }

      return UserModel.fromJson(userData);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw "Apple Sign-In failed. Please try again.";
    }
  }

  Future<UserModel?> signInWithFacebook() async {
    throw "Facebook Sign-In requires developer credentials.";
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'The email address is poorly formatted.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address.';
      default:
        return e.message ?? 'Authentication failed.';
    }
  }

  Future<void> logOut() async {
    await authServices.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    await authServices.resetPassword(email: email);
  }

  Future<void> updateUserName({required String name}) async {
    await authServices.updateUserName(name: name);
  }

  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    final uid = authServices.currentUser?.uid;

    await authServices.deleteAccount(email: email, password: password);

    if (uid != null) {
      await authServices.deleteUserData(uid: uid);
    }
  }

  Future<void> changePasswordFromCurrent({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    await authServices.restPasswordFromCurrentPassword(
      email: email,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}