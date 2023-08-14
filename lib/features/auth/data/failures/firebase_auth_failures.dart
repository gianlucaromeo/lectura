import 'package:lectura/core/failures.dart';

class FirebaseAuthEmailAlreadyInUseFailure extends ServerFailure {}
class FirebaseAuthInvalidEmailFailure extends ServerFailure {}
class FirebaseAuthOperationNotAllowedFailure extends ServerFailure {}
class FirebaseAuthWeakPasswordFailure extends ServerFailure {}
class FirebaseAuthChannelErrorFailure extends ServerFailure {}