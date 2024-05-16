import 'package:dartz/dartz.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/core/use_case.dart';
import 'package:lectura/features/auth/domain/repositories/auth_repository.dart';
import 'package:lectura/features/common/domain/repositories/user_books_repository.dart';

class DeleteUserParams {
  const DeleteUserParams(this.userId);

  final String userId;
}

class DeleteUser extends UseCase<Future<void>, DeleteUserParams> {
  DeleteUser(this.authRepository, this.booksRepository);

  final UserBooksRepository booksRepository;
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, Future<void>>> call(DeleteUserParams params) async {
    // TODO Add double check if everything went smoothly
    await booksRepository.deleteAllBooks(params.userId);
    return authRepository.deleteUser();
  }
}