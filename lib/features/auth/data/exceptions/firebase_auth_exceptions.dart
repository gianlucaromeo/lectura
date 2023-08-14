import 'package:lectura/core/exceptions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/auth/data/failures/firebase_auth_failures.dart';

final firebaseAuthExceptions = {
  "email-already-in-use": FirebaseAuthEmailAlreadyInUseException(),
  "invalid-email": FirebaseAuthInvalidEmailException(),
  "operation-not-allowed": FirebaseAuthOperationNotAllowedException(),
  "weak-password": FirebaseAuthWeakPasswordException(),
  "channel-error": FirebaseAuthChannelError(),
};

class FirebaseAuthEmailAlreadyInUseException extends ServerException {
  @override
  Failure get failure => FirebaseAuthEmailAlreadyInUseFailure();
}

class FirebaseAuthInvalidEmailException extends ServerException {
  @override
  Failure get failure => FirebaseAuthInvalidEmailFailure();
}

class FirebaseAuthOperationNotAllowedException extends ServerException {
  @override
  Failure get failure => FirebaseAuthOperationNotAllowedFailure();
}

class FirebaseAuthWeakPasswordException extends ServerException {
  @override
  Failure get failure => FirebaseAuthWeakPasswordFailure();
}

class FirebaseAuthChannelError extends ServerException {
  @override
  Failure get failure => FirebaseAuthChannelErrorFailure();
}
