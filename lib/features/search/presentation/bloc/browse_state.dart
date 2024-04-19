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
  );

  BrowseState.empty()
      : this._(
          [],
          BrowseStatus.empty,
          null,
        );

  const BrowseState.filled(List<Book> books)
      : this._(
          books,
          BrowseStatus.filled,
          null,
        );

  const BrowseState.searching(List<Book> books)
      : this._(
          books,
          BrowseStatus.searching,
          null,
        );

  const BrowseState.openedBook(List<Book> books, Book book)
      : this._(
          books,
          BrowseStatus.openedBook,
          book,
        );

  final BrowseStatus status;
  final List<Book> books;
  final Book? openedBook;

  @override
  List<Object?> get props => [
        status,
        books,
        openedBook,
      ];
}
