import 'package:movura/features/auth/data/models/user_model.dart';

abstract class LibraryState {}

class LibraryInitial extends LibraryState {}

class LibraryLoading extends LibraryState {}

class LibraryLoaded extends LibraryState {
  final UserModel? userModel;
  LibraryLoaded(this.userModel);
}

class LibraryError extends LibraryState {
  final String message;
  LibraryError(this.message);
}
