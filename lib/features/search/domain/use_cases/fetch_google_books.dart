import 'package:dartz/dartz.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/core/use_case.dart';
import 'package:lectura/features/profile/domain/entities/book.dart';
import 'package:lectura/features/search/domain/repositories/search_repository.dart';

class FetchGoogleBooksParams {
  const FetchGoogleBooksParams(this.input);
  final String? input;
}

class FetchGoogleBooks extends UseCase<void, FetchGoogleBooksParams> {
  FetchGoogleBooks(this.searchRepository);

  final SearchRepository searchRepository;

  @override
  Future<Either<Failure, List<Book>>> call(FetchGoogleBooksParams params) async {
    if (params.input?.isEmpty == true) {
      return Left(GenericFailure()); // TODO
    }
    return searchRepository.fetchBooks(params.input!);
  }

}