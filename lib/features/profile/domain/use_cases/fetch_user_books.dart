import 'package:dartz/dartz.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/core/use_case.dart';
import 'package:lectura/features/common/domain/repositories/user_books_repository.dart';
import 'package:lectura/features/search/domain/entities/book.dart';

class FetchUserBooksParams {
  const FetchUserBooksParams(this.userId);
  final String userId;
}

class FetchUserBooks extends UseCase<List<Book>, FetchUserBooksParams> {
  FetchUserBooks(UserBooksRepository userBooksRepository)
      : _userBooksRepository = userBooksRepository;

  final UserBooksRepository _userBooksRepository;

  @override
  Future<Either<Failure, List<Book>>> call(FetchUserBooksParams params) async {
    final resp = await _userBooksRepository.fetchAllBooks(params.userId);
    if (resp.isFailure) {
      return Left(resp.failure);
    }
    return Right(resp.books);
  }
}
