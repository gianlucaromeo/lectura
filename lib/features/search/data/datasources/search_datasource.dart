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
  Future<Either<Failure, List<GoogleBookResultDto>>> fetchGoogleBooks(
      String input);

  Future<Either<Failure, GoogleBookResultDto>> addGoogleBook(
      String userId, String bookId, String status);

  Future<Either<Failure, GoogleBookResultDto>> fetchGoogleBook(String bookId);

  Future<Either<Failure, List<UserBookDto>>> fetchAllUserBooks(
    String userId,
  );

  Future<List<UserBookDto>> getReadBooks(String userId) async {
    final booksSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("read")
        .get();

    final readBooksDto = booksSnapshot.docs
        .map((e) => UserBookDto(e.id, BookStatus.read))
        .toList();

    return readBooksDto;
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
      String bookId) async {
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
    String status,
  ) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection(status)
        .doc(bookId)
        .set({"date": DateTime.now().toIso8601String()});

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
      return Right(readBooksDto);
    } catch (e) {
      return Left(GenericFailure());
    }
  }
}
