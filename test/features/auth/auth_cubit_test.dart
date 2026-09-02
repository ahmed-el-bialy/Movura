import 'package:flutter_test/flutter_test.dart';
import 'package:movura/features/auth/data/models/user_model.dart';
import 'package:movura/features/auth/data/repos/auth_repo.dart';
import 'package:movura/features/auth/logic/auth/auth_cubit.dart';
import 'package:movura/features/auth/logic/auth/auth_state.dart';

class FakeAuthRepo implements AuthRepo {
  bool shouldThrow = false;
  final UserModel mockUser = UserModel(
    id: 'test_uid',
    email: 'test@example.com',
    name: 'Test User',
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<UserModel> login(String email, String password) async {
    if (shouldThrow) throw 'Invalid credentials';
    return mockUser;
  }

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    if (shouldThrow) throw 'Email already in use';
    return mockUser;
  }

  @override
  Future<void> logOut() async {}
}

void main() {
  group('AuthCubit Tests', () {
    late FakeAuthRepo fakeAuthRepo;
    late AuthCubit authCubit;

    setUp(() {
      fakeAuthRepo = FakeAuthRepo();
      authCubit = AuthCubit(fakeAuthRepo);
    });

    tearDown(() {
      authCubit.close();
    });

    test('initial state is AuthInitial', () {
      expect(authCubit.state, isA<AuthInitial>());
    });

    test('login emits AuthLoading then AuthLoaded on success', () async {
      final expectedStates = [
        isA<AuthLoading>(),
        isA<AuthLoaded>(),
      ];

      expectLater(authCubit.stream, emitsInOrder(expectedStates));

      await authCubit.login('test@example.com', 'password123');
    });

    test('login emits AuthLoading then AuthError on failure', () async {
      fakeAuthRepo.shouldThrow = true;
      final expectedStates = [
        isA<AuthLoading>(),
        isA<AuthError>(),
      ];

      expectLater(authCubit.stream, emitsInOrder(expectedStates));

      await authCubit.login('wrong@example.com', 'badpass');
    });

    test('signUp emits AuthLoading then AuthLoaded on success', () async {
      final expectedStates = [
        isA<AuthLoading>(),
        isA<AuthLoaded>(),
      ];

      expectLater(authCubit.stream, emitsInOrder(expectedStates));

      await authCubit.signUp(
        name: 'Test User',
        email: 'test@example.com',
        password: 'password123',
      );
    });

    test('logout emits AuthLoading then AuthLoggedOut', () async {
      final expectedStates = [
        isA<AuthLoading>(),
        isA<AuthLoggedOut>(),
      ];

      expectLater(authCubit.stream, emitsInOrder(expectedStates));

      await authCubit.logout();
    });
  });
}
