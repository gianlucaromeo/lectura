import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:lectura/core/enums.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/search/data/datasources/search_datasource.dart';
import 'package:lectura/features/search/data/dto/google_book_result_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lectura/features/search/data/dto/user_book_dto.dart';

abstract class UserBooksDatasource {
  /// Stores a book with its current status (read, currently reading, to read)
  Future<Either<Failure, GoogleBookResultDto>> addBook({
    required String userId,
    required String bookId,
    required BookStatus status,
  });

  /// Fetches all the stored user's books
  Future<Either<Failure, List<UserBookDto>>> fetchAllUserBooks(
    String userId,
  );

  /// Delete the book from the user's collection and returns either a failure
  /// or the [bookId]
  Future<Either<Failure, String>> deleteBook(
    String userId,
    String bookId,
  );
}

class FirebaseUserBooksDatasource extends UserBooksDatasource {
  final usersCollection = "users";
  final booksCollection = "books";

  FirebaseUserBooksDatasource(SearchDatasource searchDatasource)
      : _searchDatasource = searchDatasource;
  final SearchDatasource _searchDatasource;

  /// Fetches all the user's "read" books
  // ignore: unused_element
  Future<List<UserBookDto>> _getReadBooks(String userId) async {
    return _getBooksFromStatus(userId, BookStatus.read);
  }

  /// Fetches all the user's "currently reading" books
  // ignore: unused_element
  Future<List<UserBookDto>> _getCurrentlyReadingBooks(String userId) async {
    return _getBooksFromStatus(userId, BookStatus.currentlyReading);
  }

  /// Fetches all the user's "to read" books
  // ignore: unused_element
  Future<List<UserBookDto>> _getToReadBooks(String userId) async {
    return _getBooksFromStatus(userId, BookStatus.toRead);
  }

  /// Fetches all the user's books stored with the provided status
  Future<List<UserBookDto>> _getBooksFromStatus(
    String userId,
    BookStatus status,
  ) async {
    final booksSnapshot = await FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(userId)
        .collection(booksCollection)
        .where("status", isEqualTo: status.name)
        .get();

    final booksDto =
        booksSnapshot.docs.map((e) => UserBookDto(e.id, status)).toList();

    return booksDto;
  }

  /// Fetches all the user's stored books
  Future<List<UserBookDto>> _getAllBooks(String userId) async {
    final booksSnapshot = await FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(userId)
        .collection(booksCollection)
        .get();

    final booksDto = booksSnapshot.docs.map((e) {
      return UserBookDto.fromJson(e.data());
    }).toList();

    return booksDto;
  }

  @override
  Future<Either<Failure, GoogleBookResultDto>> addBook({
    required String userId,
    required String bookId,
    required BookStatus status,
  }) async {
    FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(userId)
        .collection(booksCollection)
        .doc(bookId)
        .set({
      "bookId": bookId,
      "date": DateTime.now().toIso8601String(),
      "status": status.name,
    });

    final resp = await _searchDatasource.fetchGoogleBook(bookId);
    if (resp.isFailure) {
      log("Failure", name: "addBook");
      return Left(resp.failure); // TODO
    }

    log("Success", name: "addBook");
    return Right(resp.bookDto);
  }

  @override
  Future<Either<Failure, List<UserBookDto>>> fetchAllUserBooks(
    String userId,
  ) async {
    try {
      final allBooks = [...await _getAllBooks(userId)];

      return Right(allBooks);
    } catch (e) {
      return Left(GenericFailure()); // TODO
    }
  }

  @override
  Future<Either<Failure, String>> deleteBook(
      String userId, String bookId) async {
    return await FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(userId)
        .collection(booksCollection)
        .doc(bookId)
        .delete()
        .then(
      (doc) async {
        log("Document deleted: $bookId", name: "FirebaseUserBooksDatasource");
        return Right(bookId);
      },
      onError: (e) {
        log("Error (deleteBook): $e", name: "FirebaseUserBooksDatasource");
        return Left(GenericFailure()); // TODO
      },
    );
  }
}
