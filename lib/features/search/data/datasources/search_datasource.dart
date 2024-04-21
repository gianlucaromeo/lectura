import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:lectura/core/enums.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/search/data/dto/google_book_result_dto.dart';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lectura/features/search/data/dto/user_book_dto.dart';

abstract class SearchDatasource {
  /// Fetches a book using the Google Book API
  Future<Either<Failure, List<GoogleBookResultDto>>> fetchGoogleBooks(
    String input,
  );

  /// Stores a book with its current status (read, currently reading, to read)
  Future<Either<Failure, GoogleBookResultDto>> addGoogleBook(
    String userId,
    String bookId,
    BookStatus status,
  );

  Future<Either<Failure, GoogleBookResultDto>> fetchGoogleBook(String bookId);

  Future<Either<Failure, List<UserBookDto>>> fetchAllUserBooks(
    String userId,
  );

  Future<List<UserBookDto>> _getBooksFromStatus(
    String userId,
    BookStatus status,
  ) async {
    final booksSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("books")
        .where("status", isEqualTo: status.name)
        .get();

    final booksDto =
        booksSnapshot.docs.map((e) => UserBookDto(e.id, status)).toList();

    return booksDto;
  }

  Future<List<UserBookDto>> getAllBooks(String userId) async {
    final booksSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("books")
        .get();

    final booksDto = booksSnapshot.docs.map((e) {
      return UserBookDto.fromJson(e.data());
    }).toList();

    return booksDto;
  }

  Future<List<UserBookDto>> getReadBooks(String userId) async {
    return _getBooksFromStatus(userId, BookStatus.read);
  }

  Future<List<UserBookDto>> getCurrentlyReadingBooks(String userId) async {
    return _getBooksFromStatus(userId, BookStatus.currentlyReading);
  }

  Future<List<UserBookDto>> getToReadBooks(String userId) async {
    return _getBooksFromStatus(userId, BookStatus.toRead);
  }

  String getVolumesPath(String input) {
    return "https://www.googleapis.com/books/v1/volumes?q=$input";
  }

  String getBookPath(String volumeId) {
    return "https://www.googleapis.com/books/v1/volumes/$volumeId";
  }
}

class GoogleApiDataSource extends SearchDatasource {
  @override
  Future<Either<Failure, List<GoogleBookResultDto>>> fetchGoogleBooks(
    String input,
  ) async {
    final path = getVolumesPath(input);

    try {
      final resp = await Dio().get(path);

      final respAsJson = resp.data as Map<String, dynamic>;

      // Every book is a JSON.
      // "items" contains a list of books, so we will work with a list of json.
      // However, it is not possible to immediately cast to List<JSON>
      final List<dynamic> itemsData = respAsJson["items"];

      // Now we cast to List<JSON>
      final List<Map<String, dynamic>> booksData =
          itemsData.map((e) => (e as Map<String, dynamic>)).toList();

      final googleBooksDTOs =
          booksData.map((json) => GoogleBookResultDto.fromJson(json)).toList();
      return Right(googleBooksDTOs);
    } catch (e) {
      log(e.toString());
      // TODO
      return Left(GenericFailure()); // TODO
    }
  }

  @override
  Future<Either<Failure, GoogleBookResultDto>> fetchGoogleBook(
    String bookId,
  ) async {
    final path = getBookPath(bookId);

    try {
      final resp = await Dio().get(path);
      final respAsJson = resp.data as Map<String, dynamic>;
      final bookDto = GoogleBookResultDto.fromJson(respAsJson);
      return Right(bookDto);
    } catch (e) {
      return Left(GenericFailure()); // TODO
    }
  }

  @override
  Future<Either<Failure, GoogleBookResultDto>> addGoogleBook(
    String userId,
    String bookId,
    BookStatus status,
  ) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("books")
        .doc(bookId)
        .set({
      "bookId": bookId,
      "date": DateTime.now().toIso8601String(),
      "status": status.name,
    });

    final resp = await fetchGoogleBook(bookId);
    if (resp.isFailure) {
      return Left(resp.failure); // TODO
    }
    return Right(resp.bookDto);
  }

  @override
  Future<Either<Failure, List<UserBookDto>>> fetchAllUserBooks(
    String userId,
  ) async {
    try {
      final readBooksDto = await getReadBooks(userId);
      final currentlyReadingBooksDto = await getCurrentlyReadingBooks(userId);
      final toReadBooksDto = await getToReadBooks(userId);

      final allBooks = [...await getAllBooks(userId)];

      return Right(allBooks);
    } catch (e) {
      return Left(GenericFailure());
    }
  }
}
