import '../models/user_model.dart';
import '../web_services/auth_services.dart';

class AuthRepo {
  final AuthServices authServices;

  AuthRepo(this.authServices);

  Future<UserModel> login(String email, String password) async {
    final credential = await authServices.loginWithEmailAndPassword(
      email: email,
      password: password,
    );

    final userData = await authServices.getUserData(uid: credential.user!.uid);

    return UserModel.fromJson(userData);
  }

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
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