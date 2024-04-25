import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/common/domain/repositories/user_books_repository.dart';
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

    emit(BrowseState.searching(state.books, state.userBooks));

    await FetchBooks(_searchRepository, _userBooksRepository)
        .call(FetchBooksParams(userId: event.userId, input: event.value))
        .then(
      (resp) async {
        if (resp.isFailure) {
          log("Failure ${resp.failure}");
          emit(BrowseState.empty());
        } else {
          log("Success: ${resp.books.length}");

          final userBooksMap =
              Map.fromIterable(state.userBooks.map((e) => {e.id: e}));

          final books = resp.books
              .map((e) {
                return userBooksMap.containsKey(e.id) ? userBooksMap[e.id] : e;
              })
              .cast<Book>()
              .toList();

          emit(BrowseState.filled(
              books, state.openedBook, List.from(state.userBooks)));
        }
      },
    );
  }

  void _onAddBookRequested(
    AddBookRequested event,
    Emitter<BrowseState> emit,
  ) async {
    log("...Adding book ${event.bookId} with status ${event.status.name}");

    await AddBook(_searchRepository, _userBooksRepository)
        .call(AddBookParams(event.userId, event.bookId, event.status))
        .then((resp) {
      if (resp.isFailure) {
        log("Failure ${resp.failure}", name: "_onAddBookRequested");
        // TODO
      } else {
        final books = state.books
            .map((e) => e.id == resp.book.id ? resp.book : e)
            .toList();

        final userBooks = List.from(state.userBooks
            .map((e) => e.id == resp.book.id ? resp.book : e)).cast<Book>();

        emit(BrowseState.openedBook(books, resp.book, userBooks));
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
    emit(BrowseState.searching(state.books, state.userBooks));

    final resp = await FetchUserBooks(_userBooksRepository)
        .call(FetchUserBooksParams(event.userId));

    if (resp.isFailure) {
      emit(BrowseState.filled(state.books, state.openedBook, state.userBooks));
    } else {
      emit(BrowseState.filled(state.books, state.openedBook, resp.books));
    }
  }
}
