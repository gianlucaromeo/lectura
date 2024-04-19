part of 'browse_bloc.dart';

enum BrowseStatus { empty, searching, filled }

class BrowseState extends Equatable {
  const BrowseState._(
      this.books,
      this.status,
      );

  BrowseState.empty() : this._([], BrowseStatus.empty);

  const BrowseState.filled(List<Book> books)
      : this._(
    books,
    BrowseStatus.filled,
  );

  const BrowseState.searching(List<Book> books)
      : this._(
    books,
    BrowseStatus.searching,
  );

  final BrowseStatus status;
  final List<Book> books;

  @override
  List<Object?> get props => [
    status,
    books,
  ];
}