
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:lectura/core/enums.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/search/data/dto/google_book_result_dto.dart';
import 'package:dio/dio.dart';

abstract class SearchDatasource {
  /// Fetches a book using the Google Book API
  Future<Either<Failure, List<GoogleBookResultDto>>> fetchGoogleBooks(
    String input,
  );

  /// Fetches one book using the Google Book API
  Future<Either<Failure, GoogleBookResultDto>> fetchGoogleBook(String bookId);
}

class GoogleApiDataSource extends SearchDatasource {
  final usersCollection = "users";
  final booksCollection = "books";

  /// Returns the path to fetch a list of books using Google API
  String _getVolumesPath(String input) {
    return "https://www.googleapis.com/books/v1/volumes?q=$input";
  }

  /// Returns the path to fetch a book using Google API
  String _getBookPath(String volumeId) {
    return "https://www.googleapis.com/books/v1/volumes/$volumeId";
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
}
