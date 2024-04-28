import 'package:dartz/dartz.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/core/use_case.dart';
import 'package:lectura/features/common/domain/repositories/user_books_repository.dart';

class DeleteBookParams {
  const DeleteBookParams({
    required this.userId,
    required this.bookId,
  });

  final String userId;
  final String bookId;
}

class DeleteBook extends UseCase<String, DeleteBookParams> {
  const DeleteBook(UserBooksRepository userBooksRepository)
      : _userBooksRepository = userBooksRepository;

  final UserBooksRepository _userBooksRepository;

  @override
  Future<Either<Failure, String>> call(DeleteBookParams params) {
    return _userBooksRepository.deleteBook(
      userId: params.userId,
      bookId: params.bookId,
    );
  }
}
