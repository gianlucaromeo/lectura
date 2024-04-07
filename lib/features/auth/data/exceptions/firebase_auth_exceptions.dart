import 'package:lectura/core/exceptions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/auth/data/failures/firebase_auth_failures.dart';

final firebaseAuthExceptions = {
  // Registration
  "email-already-in-use": FirebaseAuthEmailAlreadyInUseException(),
  "invalid-email": FirebaseAuthInvalidEmailException(),
  "operation-not-allowed": FirebaseAuthOperationNotAllowedException(),
  "weak-password": FirebaseAuthWeakPasswordException(),
  "channel-error": FirebaseAuthChannelError(),

  // Login
  "user-disabled": FirebaseUserDisabledException(),
  "user-not-found": FirebaseUserNotFoundException(),
  "wrong-password": FirebaseWrongPasswordException(),

  // Registration AND Login
  "invalid-email": FirebaseAuthInvalidEmailException(),
};

// Registration
class FirebaseAuthEmailAlreadyInUseException extends ServerException {
  @override
  Failure get failure => FirebaseAuthEmailAlreadyInUseFailure();
}

// Registration
class FirebaseAuthOperationNotAllowedException extends ServerException {
  @override
  Failure get failure => FirebaseAuthOperationNotAllowedFailure();
}

// Registration
class FirebaseAuthWeakPasswordException extends ServerException {
  @override
  Failure get failure => FirebaseAuthWeakPasswordFailure();
}

// Registration
class FirebaseAuthChannelError extends ServerException {
  @override
  Failure get failure => FirebaseAuthChannelErrorFailure();
}

// Login
class FirebaseUserDisabledException extends ServerException {
  @override
  Failure get failure => throw FirebaseUserDisabledFailure();
}

// Login
class FirebaseUserNotFoundException extends ServerException {
  @override
  Failure get failure => throw FirebaseUserNotFoundFailure();
}

// Login
class FirebaseWrongPasswordException extends ServerException {
  @override
  Failure get failure => throw FirebaseWrongPasswordFailure();
}


// Registration and Login
class FirebaseAuthInvalidEmailException extends ServerException {
  @override
  Failure get failure => FirebaseAuthInvalidEmailFailure();
}