import 'package:lectura/core/exceptions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/auth/data/failures/firebase_auth_failures.dart';

// Generic
class FirebaseUserEmailIsNullException extends ServerException {
  @override
  Failure get failure => FirebaseUserEmailIsNullFailure();
}

// Generic
class FirebaseEmailNotVerifiedException extends ServerException {
  @override
  Failure get failure => FirebaseEmailNotVerifiedFailure();
}

final firebaseAuthExceptions = {
  // Registration
  "email-already-in-use": FirebaseAuthEmailAlreadyInUseException(),
  "operation-not-allowed": FirebaseAuthOperationNotAllowedException(),
  "weak-password": FirebaseAuthWeakPasswordException(),
  "channel-error": FirebaseAuthChannelError(),

  // Email Confirmation
  "invalid-id-token": FirebaseInvalidIdTokenException(),

  // Login
  "user-disabled": FirebaseUserDisabledException(),
  "wrong-password": FirebaseWrongPasswordException(),

  // Registration AND Login
  "invalid-email": FirebaseAuthInvalidEmailException(),

  // Login AND Email Confirmation
  "user-not-found": FirebaseUserNotFoundException(),
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

// Email verification
class FirebaseInvalidIdTokenException extends ServerException {
  @override
  Failure get failure => FirebaseInvalidIdTokenFailure();
}

// Login
class FirebaseUserDisabledException extends ServerException {
  @override
  Failure get failure => FirebaseUserDisabledFailure();
}

// Login
class FirebaseUserNotFoundException extends ServerException {
  @override
  Failure get failure => FirebaseUserNotFoundFailure();
}

// Login
class FirebaseWrongPasswordException extends ServerException {
  @override
  Failure get failure => FirebaseWrongPasswordFailure();
}


// Registration and Login
class FirebaseAuthInvalidEmailException extends ServerException {
  @override
  Failure get failure => FirebaseAuthInvalidEmailFailure();
}