import 'package:dartz/dartz.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/core/use_case.dart';
import 'package:lectura/features/search/domain/entities/book.dart';
import 'package:lectura/features/search/domain/entities/book_status.dart';
import 'package:lectura/features/search/domain/repositories/search_repository.dart';

class AddBookParams {
  const AddBookParams(this.userId, this.bookId, this.status);

  final String userId;
  final String bookId;
  final BookStatus status;
}

class AddBook extends UseCase<Book, AddBookParams> {
  AddBook(SearchRepository searchRepository) : _searchRepository = searchRepository;

  final SearchRepository _searchRepository;

  @override
  Future<Either<Failure, Book>> call(AddBookParams params) async {
    return _searchRepository.addBook(params.userId, params.bookId, params.status);
  }

}