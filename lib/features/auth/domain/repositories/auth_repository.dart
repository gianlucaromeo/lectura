import 'package:dartz/dartz.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/auth/data/dto/user_dto.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserDto>> loginUserWithEmailAndPassword({
    required String email,
    required String password,
});

  Future<Either<Failure, Future<void>>> logout();

  Future<Either<Failure, Future<void>>> deleteUser();
}
