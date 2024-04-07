import 'package:lectura/core/failures.dart';

// Registration
class FirebaseAuthEmailAlreadyInUseFailure extends ServerFailure {}
class FirebaseAuthOperationNotAllowedFailure extends ServerFailure {}
class FirebaseAuthWeakPasswordFailure extends ServerFailure {}
class FirebaseAuthChannelErrorFailure extends ServerFailure {}

// Login
class FirebaseUserDisabledFailure extends ServerFailure {}
class FirebaseUserNotFoundFailure extends ServerFailure {}
class FirebaseWrongPasswordFailure extends ServerFailure {}

// Registration and Login
class FirebaseAuthInvalidEmailFailure extends ServerFailure {}