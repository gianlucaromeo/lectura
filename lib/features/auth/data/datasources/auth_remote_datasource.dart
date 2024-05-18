import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  Future<UserDto> loginWithGoogle();

  Future<void> logout();

  Future<void> deleteUser();

  Stream<UserDto> get user;
}

class FirebaseAuthDataSource extends AuthRemoteDataSource {
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

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

      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
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
  Future<void> logout() async {
    if (_googleSignIn.currentUser != null) {
      await _googleSignIn.disconnect();
    }
    return await _firebaseAuth.signOut();
  }

  @override
  Future<void> deleteUser() async {
    try {
      await _firebaseAuth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      log("Error code: ${e.code}", name: "AuthRemoteDatasource");
    } catch (e) {
      log("Error deleting account $e", name: "AuthRemoteDatasource");
    }
  }

  @override
  Stream<UserDto> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null || !firebaseUser.emailVerified
          ? UserDto.empty()
          : UserDto(id: firebaseUser.uid, email: firebaseUser.email);
    });
  }

  @override
  Future<UserDto> loginWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();

      if (account == null) {
        throw GenericException(); // TODO
      }

      final authentication = await account.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user != null) {
        return UserDto(
          id: _firebaseAuth.currentUser!.uid,
          email: _firebaseAuth.currentUser!.email, // TODO Check if it works
        );
      } else {
        throw GenericException(); // TODO
      }
    }
    catch (e) {
      log("Error during sign in with Google: $e");
      throw GenericException(); // TODO
    }
  }
}
