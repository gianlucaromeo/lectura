part of 'browse_bloc.dart';

enum BrowseStatus {
  empty,
  searching,
  filled,
  openedBook,
}

class BrowseState extends Equatable {
  const BrowseState._(
    this.books,
    this.status,
    this.openedBook,
    this.userBooks,
  );

  BrowseState.empty()
      : this._(
          [],
          BrowseStatus.empty,
          null,
          [],
        );

  const BrowseState.filled(List<Book> books, List<Book> userBooks)
      : this._(
          books,
          BrowseStatus.filled,
          null,
          userBooks,
        );

  const BrowseState.searching(List<Book> books, List<Book> userBooks)
      : this._(
          books,
          BrowseStatus.searching,
          null,
          userBooks,
        );

  const BrowseState.openedBook(
    List<Book> books,
    Book book,
    List<Book> userBooks,
  ) : this._(books, BrowseStatus.openedBook, book, userBooks);

  final BrowseStatus status;
  final List<Book> books;
  final List<Book> userBooks;
  final Book? openedBook;

  @override
  List<Object?> get props => [
        status,
        books,
        openedBook,
        userBooks,
      ];
}
