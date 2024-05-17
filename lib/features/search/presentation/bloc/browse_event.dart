part of 'browse_bloc.dart';

sealed class BrowseEvent {}

final class BrowseInputChanged extends BrowseEvent {
  BrowseInputChanged({
    required this.value,
    required this.userId,
  });

  final String value;
  final String userId;
}

final class AddBookRequested extends BrowseEvent {
  AddBookRequested(this.userId, this.bookId, this.status);

  final String userId;
  final String bookId;
  final BookStatus status;
}

final class OpenBookRequested extends BrowseEvent {
  OpenBookRequested(this.book);

  final Book book;
}

final class FetchUserBooksRequested extends BrowseEvent {
  FetchUserBooksRequested(this.userId);

  final String userId;
}

final class BookDeleteRequested extends BrowseEvent {
  BookDeleteRequested({
    required this.userId,
    required this.bookId,
  });

  final String userId;
  final String bookId;
}

final class ResetBrowseBlocRequested extends BrowseEvent {}