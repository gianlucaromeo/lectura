import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/common/domain/repositories/user_books_repository.dart';
import 'package:lectura/features/common/domain/use_cases/delete_book_use_case.dart';
import 'package:lectura/features/profile/domain/use_cases/fetch_user_books.dart';
import 'package:lectura/features/search/domain/entities/book.dart';
import 'package:lectura/core/enums.dart';
import 'package:lectura/features/search/domain/repositories/search_repository.dart';
import 'package:lectura/features/search/domain/use_cases/add_book.dart';
import 'package:lectura/features/search/domain/use_cases/fetch_books.dart';
import 'package:rxdart/rxdart.dart';

part 'browse_event.dart';
part 'browse_state.dart';

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  BrowseBloc(
    SearchRepository searchRepository,
    UserBooksRepository userBooksRepository,
  )   : _searchRepository = searchRepository,
        _userBooksRepository = userBooksRepository,
        super(BrowseState.empty()) {
    on<BrowseInputChanged>(
      _onBrowseInputChanged,
      transformer: _debounceSequential(const Duration(milliseconds: 300)),
    );
    on<AddBookRequested>(_onAddBookRequested);
    on<OpenBookRequested>(_onOpenBookRequested);
    on<FetchUserBooksRequested>(_onFetchUserBooksRequested);
    on<BookDeleteRequested>(_onBookDeleteRequested);
  }

  final SearchRepository _searchRepository;
  final UserBooksRepository _userBooksRepository;

  EventTransformer<BrowseInputChanged> _debounceSequential<BrowseInputChanged>(
    Duration duration,
  ) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }

  void _onBrowseInputChanged(
    BrowseInputChanged event,
    Emitter<BrowseState> emit,
  ) async {
    if (event.value.isEmpty == true) {
      emit(BrowseState.empty());
      return;
    }

    emit(BrowseState.searching(state.books, state.openedBook, state.userBooks));

    await FetchBooks(_searchRepository, _userBooksRepository)
        .call(FetchBooksParams(userId: event.userId, input: event.value))
        .then(
      (resp) async {
        if (resp.isFailure) {
          emit(BrowseState.empty());
        } else {
          final userBooksMap =
              Map.fromIterable(state.userBooks.map((e) => {e.id: e}));

          final books = List<Book>.from(resp.books.map((e) {
            return userBooksMap.containsKey(e.id) ? userBooksMap[e.id] : e;
          }));

          emit(BrowseState.filled(
            books,
            state.openedBook,
            state.userBooks,
          ));
        }
      },
    );
  }

  void _onAddBookRequested(
    AddBookRequested event,
    Emitter<BrowseState> emit,
  ) async {
    log("...Adding book ${event.bookId} with status ${event.status.name}");
    emit(BrowseState.searching(state.books, state.openedBook, state.userBooks));

    await AddBook(_searchRepository, _userBooksRepository)
        .call(AddBookParams(event.userId, event.bookId, event.status))
        .then((resp) {
      if (resp.isFailure) {
        log("Failure", name: "_onAddBookRequested");
      } else {
        final books = List<Book>.from(
            state.books.map((e) => e.id == resp.book.id ? resp.book : e));

        // TODO Find a better and more optimized way to handle this
        // If book is already in user's db, change status
        // Otherwise, add it
        final isUpdating =
            state.userBooks.where((e) => e.id == resp.book.id).isNotEmpty;

        List<Book> updatedUserBooks;
        if (isUpdating) {
          updatedUserBooks = List<Book>.from(
              state.userBooks.map((e) => e.id == resp.book.id ? resp.book : e));
        } else {
          updatedUserBooks = List.from([
            ...state.userBooks,
            resp.book.copyWith(status: event.status)
          ]).cast<Book>();
        }

        emit(BrowseState.openedBook(books, resp.book, updatedUserBooks));
      }
    });
  }

  void _onOpenBookRequested(
    OpenBookRequested event,
    Emitter<BrowseState> emit,
  ) {
    emit(BrowseState.openedBook(state.books, event.book, state.userBooks));
  }

  void _onFetchUserBooksRequested(
    FetchUserBooksRequested event,
    Emitter<BrowseState> emit,
  ) async {
    emit(BrowseState.searching(state.books, state.openedBook, state.userBooks));

    final resp = await FetchUserBooks(_userBooksRepository)
        .call(FetchUserBooksParams(event.userId));

    if (resp.isFailure) {
      emit(BrowseState.filled(state.books, state.openedBook, state.userBooks));
    } else {
      emit(BrowseState.filled(state.books, state.openedBook, resp.books));
    }
  }

  void _onBookDeleteRequested(
    BookDeleteRequested event,
    Emitter<BrowseState> emit,
  ) async {
    log("Book delete requested", name: "BrowseBloc");
    emit(BrowseState.searching(state.books, state.openedBook, state.userBooks));

    final resp = await DeleteBook(_userBooksRepository).call(DeleteBookParams(
      userId: event.userId,
      bookId: event.bookId,
    ));

    if (resp.isFailure) {
      // TODO Handle failure
      emit(BrowseState.filled(state.books, state.openedBook, state.userBooks));
    } else {
      // Book deleted
      final deletedBookId = resp.stringValue;
      log("Number of books: ${state.userBooks}");

      final updatedUserBooks = List<Book>.from(state.userBooks)
        ..removeWhere((e) => e.id == deletedBookId);

      // If the removed book is a search result, the status needs to be updated
      final updatedBooks = List<Book>.from(
        state.books.map(
          (e) => e.id == deletedBookId
              ? e.copyWith(status: BookStatus.unknown)
              : e,
        ),
      );

      final updatedOpenBook = state.openedBook?.id == deletedBookId
          ? state.openedBook!.copyWith(status: BookStatus.unknown)
          : state.openedBook;
      emit(BrowseState.filled(updatedBooks, updatedOpenBook, updatedUserBooks));
    }
  }
}
