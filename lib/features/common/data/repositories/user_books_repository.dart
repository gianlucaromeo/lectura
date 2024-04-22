import 'package:dartz/dartz.dart';
import 'package:lectura/core/enums.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/common/data/datasources/user_books_datasource.dart';
import 'package:lectura/features/common/domain/repositories/user_books_repository.dart';
import 'package:lectura/features/search/data/datasources/search_datasource.dart';
import 'package:lectura/features/search/domain/entities/book.dart';

class FirebaseUserBooksRepository implements UserBooksRepository {
  FirebaseUserBooksRepository(
    UserBooksDatasource userBooksDatasource,
    SearchDatasource searchDatasource,
  )   : _userBooksDatasource = userBooksDatasource,
        _searchDatasource = searchDatasource;

  final UserBooksDatasource _userBooksDatasource;
  final SearchDatasource _searchDatasource;

  @override
  Future<Either<Failure, List<Book>>> fetchAllBooks(
    String userId,
  ) async {
    final resp = await _userBooksDatasource.fetchAllUserGoogleBooks(userId);

    if (resp.isFailure) {
      return Left(resp.failure);
    }

    final futures = resp.googleUserBooksDTOs.map((e) async {
      final book = await _searchDatasource.fetchGoogleBook(e.bookId);
      return book.bookDto.toEntity().copyWith(status: e.status);
    }).toList();

    final books = await futures.wait;

    return Right(books);
  }

  @override
  Future<Either<Failure, Book>> addBook(
    String userId,
    String bookId,
    BookStatus status,
  ) async {
    final resp = await _userBooksDatasource.addBook(
      userId: userId,
      bookId: bookId,
      status: status,
    );

    if (resp.isFailure) {
      return Left(resp.failure);
    }

    return Right(resp.bookDto.toEntity().copyWith(status: status));
  }
}
