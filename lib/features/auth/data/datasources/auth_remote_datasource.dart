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
}

class FirebaseAuthDataSource extends AuthRemoteDataSource {
  @override
  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      email = email.trim();
      final userCredentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredentials.user?.sendEmailVerification();
      return true;
    } on FirebaseAuthException catch (e) {
      if (firebaseAuthExceptions.containsKey(e.code)) {
        log("Firebase Registration Exception: ${e.code}", name: "App Exception");
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

      final credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
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
    return FirebaseAuth.instance.signOut();
  }
}
