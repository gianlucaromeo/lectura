import 'package:dartz/dartz.dart';
import 'package:lectura/core/enums.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/search/domain/entities/book.dart';

abstract class UserBooksRepository {
  Future<Either<Failure, List<Book>>> fetchAllBooks(String userId);

  /// If successful, returns a [Book] with the provided [status]
  Future<Either<Failure, Book>> addBook(
    String userId,
    String bookId,
    BookStatus status,
  );

  Future<Either<Failure, String>> deleteBook({
    required String userId,
    required String bookId,
  });
}
