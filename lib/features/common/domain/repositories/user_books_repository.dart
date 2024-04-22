import 'package:dartz/dartz.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/search/domain/entities/book.dart';

abstract class UserBooksRepository {
  Future<Either<Failure, List<Book>>> fetchAllBooks(String userId);
}