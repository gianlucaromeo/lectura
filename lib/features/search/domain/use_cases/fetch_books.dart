import 'package:dartz/dartz.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/core/use_case.dart';
import 'package:lectura/features/search/domain/entities/book.dart';
import 'package:lectura/features/search/domain/repositories/search_repository.dart';

class FetchBooksParams {
  const FetchBooksParams({
    required this.input,
    required this.userId,
  });
  final String input;
  final String userId;
}

class FetchBooks extends UseCase<void, FetchBooksParams> {
  FetchBooks(this.searchRepository);

  final SearchRepository searchRepository;

  @override
  Future<Either<Failure, List<Book>>> call(FetchBooksParams params) async {
    if (params.input.isEmpty == true) {
      return Left(GenericFailure()); // TODO
    }

    final userBooks = await searchRepository.fetchAllUserBooks(params.userId);
    final fetchedBooks = await searchRepository.fetchBooks(params.input);

    if (userBooks.isFailure) {
      return Left(userBooks.failure);
    }

    if (fetchedBooks.isFailure) {
      return Left(fetchedBooks.failure);
    }

    final userBooksAsMap = {for (var e in userBooks.books) e.id: e};

    final updatedBooks = fetchedBooks.books
        .map((e) => userBooksAsMap.containsKey(e.id)
            ? e.copyWith(status: userBooksAsMap[e.id]!.status)
            : e)
        .toList();

    return Right(updatedBooks);
  }
}
