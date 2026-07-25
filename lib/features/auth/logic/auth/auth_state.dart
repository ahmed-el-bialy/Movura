import '../../data/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final UserModel user;
  AuthLoaded(this.user);
}

class AuthLoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
