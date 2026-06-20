import 'package:firebase_auth/firebase_auth.dart';

import '../web_services/auth_services.dart';

class AuthRepo {
  final AuthServices authServices;

  AuthRepo(this.authServices);

  Future<UserCredential> login(String email, String password) async {
    return await authServices.loginWithEmailAndPassword(
      email: email,

      password: password,
    );
  }

  Future<UserCredential> signUp(String email, String password) async {
    return await authServices.signUpWithEmailAndPassword(
      email: email,

      password: password,
    );
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
    await authServices.deleteAccount(email: email, password: password);
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
