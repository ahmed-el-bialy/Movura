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
        // Handle case where user exists in Auth but not in Firestore
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

  Future<UserModel> signInWithGoogle() async {
    // TODO: Implement Google Sign-In logic with Firebase
    throw "Google Sign-In not implemented yet.";
  }

  Future<UserModel> signInWithFacebook() async {
    // TODO: Implement Facebook Sign-In logic with Firebase
    throw "Facebook Sign-In not implemented yet.";
  }

  Future<UserModel> signInWithApple() async {
    // TODO: Implement Apple Sign-In logic with Firebase
    throw "Apple Sign-In not implemented yet.";
  }
}