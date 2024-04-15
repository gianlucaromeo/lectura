import 'package:dartz/dartz.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/profile/domain/entities/book.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Book>>> fetchBooks(String input);
}
