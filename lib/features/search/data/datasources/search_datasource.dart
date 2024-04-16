import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/profile/data/dto/google_book_dto.dart';
import 'package:dio/dio.dart';

abstract class SearchDatasource {
  Future<Either<Failure, List<GoogleBookDto>>> fetchGoogleBooks(String input);
}

class GoogleApiDataSource extends SearchDatasource {
  @override
  Future<Either<Failure, List<GoogleBookDto>>> fetchGoogleBooks(
      String input) async {
    final path = "https://www.googleapis.com/books/v1/volumes?q=$input";

    final resp = await Dio().get(path);

    try {
      final respAsJson = resp.data as Map<String, dynamic>;

      // Every book is a JSON.
      // "items" contains a list of books, so we will work with a list of json.
      // However, it is not possible to immediately cast to List<JSON>
      final List<dynamic> itemsData = respAsJson["items"];

      // Now we cast to List<JSON>
      final List<Map<String, dynamic>> booksData =
          itemsData.map((e) => (e as Map<String, dynamic>)).toList();

      final googleBooksDTOs =
          booksData.map((json) => GoogleBookDto.fromJson(json)).toList();
      return Right(googleBooksDTOs);
    } catch (e) {
      log(e.toString());
      // TODO
      return Left(GenericFailure()); // TODO
    }
  }
}
