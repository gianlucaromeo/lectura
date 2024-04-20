import 'package:dartz/dartz.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/search/domain/entities/book.dart';
import 'package:lectura/features/search/data/datasources/search_datasource.dart';
import 'package:lectura/core/enums.dart';
import 'package:lectura/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  const SearchRepositoryImpl(this.searchDatasource);

  final SearchDatasource searchDatasource;

  @override
  Future<Either<Failure, List<Book>>> fetchBooks(String input) async {
    final resp = await searchDatasource.fetchGoogleBooks(input);

    if (resp.isFailure) {
      return Left(resp.failure);
    }

    final books = resp.googleBooksDTOs
        .where((dto) => dto.isValid)
        .map((dto) => dto.toEntity())
        .toList();

    return Right(books);
  }

  @override
  Future<Either<Failure, Book>> addBook(
      String userId, String bookId, BookStatus status) async {
    final resp =
        await searchDatasource.addGoogleBook(userId, bookId, status.name);

    if (resp.isFailure) {
      return Left(resp.failure);
    }

    final book = resp.bookDto.toEntity().copyWith(status: status);
    return Right(book);
  }

  @override
  Future<Either<Failure, List<Book>>> fetchAllUserBooks(
    String userId,
  ) async {
    final resp = await searchDatasource.fetchAllUserBooks(userId);

    if (resp.isFailure) {
      return Left(resp.failure);
    }

    final futures = resp.googleUserBooksDTOs.map((e) async {
      final book = await searchDatasource.fetchGoogleBook(e.bookId);
      return book.bookDto.toEntity().copyWith(status: e.status);
    }).toList();

    final books = await futures.wait;

    return Right(books);
  }
}
