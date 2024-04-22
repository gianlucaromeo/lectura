import 'package:dartz/dartz.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/core/use_case.dart';
import 'package:lectura/features/common/domain/repositories/user_books_repository.dart';
import 'package:lectura/features/search/domain/entities/book.dart';
import 'package:lectura/core/enums.dart';
import 'package:lectura/features/search/domain/repositories/search_repository.dart';

class AddBookParams {
  const AddBookParams(this.userId, this.bookId, this.status);

  final String userId;
  final String bookId;
  final BookStatus status;
}

class AddBook extends UseCase<Book, AddBookParams> {
  AddBook(SearchRepository searchRepository,
      UserBooksRepository userBooksRepository)
      : _userBooksRepository = userBooksRepository;

  final UserBooksRepository _userBooksRepository;

  @override
  Future<Either<Failure, Book>> call(AddBookParams params) async {
    final resp = await _userBooksRepository.addBook(
      params.userId,
      params.bookId,
      params.status,
    );

    if (resp.isFailure) {
      return Left(resp.failure);
    }

    return Right(resp.book);
  }
}
