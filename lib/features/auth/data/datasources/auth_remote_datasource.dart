import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:lectura/features/auth/data/exceptions/firebase_auth_exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class FirebaseAuthDataSource extends AuthRemoteDataSource {
  @override
  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      email = email.trim();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (firebaseAuthExceptions
          .containsKey(e.code)) {
        log("Firebase Auth Exception: ${e.code}", name: "App Exception");
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
}
