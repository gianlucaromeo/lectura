
import 'package:dartz/dartz.dart';
import 'package:lectura/core/enums.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/search/data/dto/google_book_result_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lectura/features/search/data/dto/user_book_dto.dart';
import 'package:lectura/features/search/domain/repositories/search_repository.dart';

abstract class UserBooksDatasource {


  /// Stores a book with its current status (read, currently reading, to read)
  Future<Either<Failure, GoogleBookResultDto>> addGoogleBook({
    required String userId,
    required String bookId,
    required BookStatus status,
  });



  /// Fetches all the stored user's books
  Future<Either<Failure, List<UserBookDto>>> fetchAllUserGoogleBooks(
      String userId,
      );
}

class FirebaseUserBooksDatasource extends UserBooksDatasource {
  final usersCollection = "users";
  final booksCollection = "books";

  FirebaseUserBooksDatasource(SearchRepository searchRepository) : _searchRepository = searchRepository;
  final SearchRepository _searchRepository;

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

    final resp = await _searchRepository.fetchBookById(bookId);
    if (resp.isFailure) {
      return Left(resp.failure); // TODO
    }
    return Right(GoogleBookResultDto.fromEntity(resp.book));
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
