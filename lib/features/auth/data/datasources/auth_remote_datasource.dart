import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:lectura/core/exceptions.dart';
import 'package:lectura/features/auth/data/dto/user_dto.dart';
import 'package:lectura/features/auth/data/exceptions/firebase_auth_exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserDto> loginUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<void> deleteUser();

  Stream<UserDto> get user;
}

class FirebaseAuthDataSource extends AuthRemoteDataSource {

  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      email = email.trim();
      final userCredentials =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredentials.user?.sendEmailVerification();
      return true;
    } on FirebaseAuthException catch (e) {
      if (firebaseAuthExceptions.containsKey(e.code)) {
        log("Firebase Registration Exception: ${e.code}",
            name: "App Exception");
        throw firebaseAuthExceptions[e.code]!;
      } else {
        log(
          "Unhandled exception. Code: ${e.code}, message: ${e.message}",
          name: "App Exception",
        );
        rethrow;
      }
    }
  }

  @override
  Future<UserDto> loginUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      email = email.trim();

      final credentials =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credentials.user == null) {
        log("Error: credentials.user is null");
        throw GenericException(); // TODO Handle this case
      }

      // TODO Check if needed
      //if (credentials.user!.email == null) {
      //  throw FirebaseUserEmailIsNullException();
      //}

      if (!credentials.user!.emailVerified) {
        log("Error: credentials.user.emailVerified is false");
        throw FirebaseEmailNotVerifiedException();
      }

      return UserDto(
        id: credentials.user!.uid,
        email: credentials.user!.email,
      );
    } on FirebaseAuthException catch (e) {
      if (firebaseAuthExceptions.containsKey(e.code)) {
        log("Firebase Login Exception: ${e.code}", name: "App Exception");
        throw firebaseAuthExceptions[e.code]!;
      } else {
        log(
          "Unhandled exception. Code: ${e.code}, message: ${e.message}",
          name: "App Exception",
        );
        rethrow;
      }
    }
  }

  @override
  Future<void> logout() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<void> deleteUser() {
    return _firebaseAuth.currentUser?.delete() ?? Future.value();
  }

  @override
  Stream<UserDto> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
     return firebaseUser == null
          ? UserDto.empty()
          : UserDto(id: firebaseUser.uid, email: firebaseUser.email);
    });
  }
}
