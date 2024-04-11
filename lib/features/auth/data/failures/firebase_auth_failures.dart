import 'package:lectura/core/failures.dart';

// Generic
class FirebaseUserEmailIsNullFailure extends ServerFailure {}
class FirebaseEmailNotVerifiedFailure extends ServerFailure {}

// Registration
class FirebaseAuthEmailAlreadyInUseFailure extends ServerFailure {}
class FirebaseAuthOperationNotAllowedFailure extends ServerFailure {}
class FirebaseAuthWeakPasswordFailure extends ServerFailure {}
class FirebaseAuthChannelErrorFailure extends ServerFailure {}

// Email Confirmation
class FirebaseInvalidIdTokenFailure extends ServerFailure {}

// Login
class FirebaseUserDisabledFailure extends ServerFailure {}
class FirebaseWrongPasswordFailure extends ServerFailure {}

// Registration AND Login
class FirebaseAuthInvalidEmailFailure extends ServerFailure {}

// Login AND Email Confirmation
class FirebaseUserNotFoundFailure extends ServerFailure {}
