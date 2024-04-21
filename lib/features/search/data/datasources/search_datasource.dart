
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
  Future<Either<Failure, GoogleBookResultDto>> addGoogleBook({
    required String userId,
    required String bookId,
    required BookStatus status,
  });

  /// Fetches one book using the Google Book API
  Future<Either<Failure, GoogleBookResultDto>> fetchGoogleBook(String bookId);

  /// Fetches all the stored user's books
  Future<Either<Failure, List<UserBookDto>>> fetchAllUserGoogleBooks(
    String userId,
  );
}

class GoogleApiDataSource extends SearchDatasource {
  final usersCollection = "users";
  final booksCollection = "books";

  /// Fetches all the user's "read" books
  Future<List<UserBookDto>> _getReadBooks(String userId) async {
    return _getBooksFromStatus(userId, BookStatus.read);
  }

  /// Fetches all the user's "currently reading" books
  Future<List<UserBookDto>> _getCurrentlyReadingBooks(String userId) async {
    return _getBooksFromStatus(userId, BookStatus.currentlyReading);
  }

  /// Fetches all the user's "to read" books
  Future<List<UserBookDto>> _getToReadBooks(String userId) async {
    return _getBooksFromStatus(userId, BookStatus.toRead);
  }

  /// Returns the path to fetch a list of books using Google API
  String _getVolumesPath(String input) {
    return "https://www.googleapis.com/books/v1/volumes?q=$input";
  }

  /// Returns the path to fetch a book using Google API
  String _getBookPath(String volumeId) {
    return "https://www.googleapis.com/books/v1/volumes/$volumeId";
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
  Future<Either<Failure, List<GoogleBookResultDto>>> fetchGoogleBooks(
    String input,
  ) async {
    final path = _getVolumesPath(input);

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
      return Left(GenericFailure()); // TODO
    }
  }

  @override
  Future<Either<Failure, GoogleBookResultDto>> fetchGoogleBook(
    String bookId,
  ) async {
    final path = _getBookPath(bookId);

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
  Future<Either<Failure, GoogleBookResultDto>> addGoogleBook({
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

    final resp = await fetchGoogleBook(bookId);
    if (resp.isFailure) {
      return Left(resp.failure); // TODO
    }
    return Right(resp.bookDto);
  }

  @override
  Future<Either<Failure, List<UserBookDto>>> fetchAllUserGoogleBooks(
    String userId,
  ) async {
    try {
      final allBooks = [...await _getAllBooks(userId)];

      return Right(allBooks);
    } catch (e) {
      return Left(GenericFailure()); // TODO
    }
  }
}
