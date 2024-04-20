import 'package:dartz/dartz.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/search/domain/entities/book.dart';
import 'package:lectura/core/enums.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Book>>> fetchBooks(String input);

  Future<Either<Failure, Book>> addBook(
    String userId,
    String bookId,
    BookStatus status,
  );

  Future<Either<Failure, List<Book>>> fetchAllUserBooks(
    String userId,
  );
}
