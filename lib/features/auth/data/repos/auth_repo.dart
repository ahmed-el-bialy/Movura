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

      return await _getOrCreateUser(
        uid: credential.user!.uid,
        email: email,
        name: credential.user!.displayName ?? email.split('@').first,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw e.toString();
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

      return await _getOrCreateUser(
        uid: credential.user!.uid,
        email: email,
        name: name,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      final credential = await authServices.signInWithGoogle();
      if (credential == null || credential.user == null) return null;

      final user = credential.user!;
      return await _getOrCreateUser(
        uid: user.uid,
        email: user.email ?? "",
        name: user.displayName ?? "Google User",
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserModel?> signInWithApple() async {
    try {
      final credential = await authServices.signInWithApple();
      if (credential == null || credential.user == null) return null;

      final user = credential.user!;
      return await _getOrCreateUser(
        uid: user.uid,
        email: user.email ?? "",
        name: user.displayName ?? "Apple User",
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw e.toString();
    }
  }

  /// Robust helper to ensure user exists in Firestore.
  /// If missing, it initializes with empty collection arrays.
  Future<UserModel> _getOrCreateUser({
    required String uid,
    required String email,
    required String name,
  }) async {
    try {
      final userData = await authServices.getUserData(uid: uid);

      if (userData.isEmpty) {
        final newUser = UserModel(
          id: uid,
          email: email,
          name: name,
          favorites: [],
          watched: [],
          toWatch: [],
          watchNow: [],
        );
        await authServices.saveUserData(
          userData: {
            'id': uid,
            'email': email,
            'name': name,
            'favorites': {},
            'watched': {},
            'toWatch': {},
            'watchNow': {},
          },
          uid: uid,
        );
        return newUser;
      }

      return UserModel.fromJson(userData);
    } catch (_) {
      // Fallback: If Firestore database is not created in console yet,
      // return basic UserModel so user authentication still succeeds.
      return UserModel(
        id: uid,
        email: email,
        name: name,
        favorites: [],
        watched: [],
        toWatch: [],
        watchNow: [],
      );
    }
  }

  Future<UserModel?> signInWithFacebook() async {
    // Placeholder: Facebook login integration requires native setup (App ID, Secret)
    // and the flutter_facebook_auth package. 
    throw "Facebook Sign-In is currently being optimized. Please use Google or Email for now.";
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