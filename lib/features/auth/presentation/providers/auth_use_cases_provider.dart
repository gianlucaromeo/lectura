import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/auth/domain/repositories/auth_repository.dart';
import 'package:lectura/features/auth/domain/use_cases/create_user_with_email_and_password.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_use_cases_provider.g.dart';

@Riverpod()  // TODO Check why it gets disposed when changing tab Login/Sign Up
class AuthUseCases extends _$AuthUseCases {
  AuthRepository? _authRepository;

  @override
  FutureOr<Either<Failure, dynamic>> build() {
    ref.onDispose(() {
      log("Provider disposed ${toString()}\n", name: "AuthUseCases");
    });
    return const Right(null);
  }

  void initialize(AuthRepository authRepository) {
    log("AuthUseCasesProvider initialized\n");
    _authRepository = authRepository;
    log("$_authRepository\n");
  }

  void _checkInitialization() {
    if (_authRepository == null) {
      throw UnimplementedError(
        'AuthRepository must be initialized before using createUserWithEmailAndPassword.',
      );
    }
  }

  void createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _checkInitialization();

    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => CreateUserWithEmailAndPassword(_authRepository!).call(
        EmailAndPasswordAuthParams(
          email: email,
          password: password,
        ),
      ),
    );
  }
}
