import 'package:dartz/dartz.dart';
import 'package:lectura/core/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
}
