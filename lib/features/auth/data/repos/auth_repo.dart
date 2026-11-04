import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<UserModel> _getOrCreateUser({
    required String uid,
    required String email,
    required String name,
  }) async {
    Map<String, dynamic> userData = {};
    try {
      userData = await authServices.getUserData(uid: uid);
    } catch (_) {
      userData = {};
    }

    if (userData.isEmpty) {
      final newUserMap = _newUserDocument(uid: uid, email: email, name: name);
      await authServices.saveUserData(userData: newUserMap, uid: uid);
      return UserModel.fromJson(newUserMap);
    }

    await _migrateLegacyUserDocument(
      uid: uid,
      email: email,
      name: name,
      userData: userData,
    );
    return UserModel.fromJson(userData);
  }

  /// New: Ensures the user document on Firebase is populated if it exists but is empty.
  Future<void> syncUserRecordIfNeeded() async {
    final user = authServices.currentUser;
    if (user == null) return;

    try {
      final userData = await authServices.getUserData(uid: user.uid);
      if (userData.isEmpty) {
        await authServices.saveUserData(
          uid: user.uid,
          userData: _newUserDocument(
            uid: user.uid,
            email: user.email ?? '',
            name: user.displayName ?? 'Cinematic Explorer',
          ),
        );
      } else {
        await _migrateLegacyUserDocument(
          uid: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? 'Cinematic Explorer',
          userData: userData,
        );
      }
    } catch (_) {}
  }

  Map<String, dynamic> _newUserDocument({
    required String uid,
    required String email,
    required String name,
  }) {
    return {
      'schemaVersion': 2,
      'profile': {
        'id': uid,
        'email': email,
        'name': name,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      'library': _emptyLibrary(),
    };
  }

  Map<String, dynamic> _emptyLibrary() => {
    'favorites': {'movies': {}, 'tvSeries': {}},
    'toWatch': {'movies': {}, 'tvSeries': {}},
    'watched': {'movies': {}, 'tvSeries': {}},
    'watchNow': {'movies': {}, 'tvSeries': {}},
  };

  Future<void> _migrateLegacyUserDocument({
    required String uid,
    required String email,
    required String name,
    required Map<String, dynamic> userData,
  }) async {
    if (userData['schemaVersion'] == 2 && userData['library'] is Map) return;

    final legacyCollections = <String, dynamic>{};
    for (final collection in ['favorites', 'toWatch', 'watched', 'watchNow']) {
      legacyCollections[collection] = _splitLegacyCollection(
        userData[collection],
      );
    }

    await authServices.saveUserData(
      uid: uid,
      userData: {
        'schemaVersion': 2,
        'profile': {
          'id': uid,
          'email': email,
          'name': name,
          'updatedAt': FieldValue.serverTimestamp(),
        },
        'library': legacyCollections,
        'favorites': FieldValue.delete(),
        'toWatch': FieldValue.delete(),
        'watched': FieldValue.delete(),
        'watchNow': FieldValue.delete(),
      },
    );
  }

  Map<String, dynamic> _splitLegacyCollection(dynamic value) {
    final movies = <String, dynamic>{};
    final tvSeries = <String, dynamic>{};

    void addPoster(Object? key, dynamic rawPoster) {
      if (rawPoster is! Map) return;
      final poster = Map<String, dynamic>.from(rawPoster);
      final bucket = poster['media_type'] == 'tv' ? tvSeries : movies;
      final itemId = poster['id']?.toString() ?? key.toString();
      bucket[itemId] = poster;
    }

    if (value is Map) {
      for (final entry in value.entries) {
        addPoster(entry.key, entry.value);
      }
    } else if (value is List) {
      for (final entry in value.indexed) {
        addPoster(entry.$1, entry.$2);
      }
    }
    return {'movies': movies, 'tvSeries': tvSeries};
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
