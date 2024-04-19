import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/search/domain/entities/book.dart';
import 'package:lectura/features/search/domain/entities/book_status.dart';
import 'package:lectura/features/search/domain/repositories/search_repository.dart';
import 'package:lectura/features/search/domain/use_cases/add_book.dart';
import 'package:lectura/features/search/domain/use_cases/fetch_google_books.dart';
import 'package:rxdart/rxdart.dart';

part 'browse_event.dart';
part 'browse_state.dart';

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  BrowseBloc(SearchRepository searchRepository)
      : _searchRepository = searchRepository,
        super(BrowseState.empty()) {
    on<BrowseInputChanged>(
      _onBrowseInputChanged,
      transformer: _debounceSequential(const Duration(milliseconds: 300)),
    );

    on<AddBookRequested>(_onAddBookRequested);

    on<OpenBookRequested>(_onOpenBookRequested);
  }

  final SearchRepository _searchRepository;

  EventTransformer<BrowseInputChanged> _debounceSequential<BrowseInputChanged>(
    Duration duration,
  ) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }

  void _onBrowseInputChanged(
    BrowseInputChanged event,
    Emitter<BrowseState> emit,
  ) async {
    if (event.value?.isEmpty == true) {
      emit(BrowseState.empty());
      return;
    }

    emit(BrowseState.searching(state.books));

    await FetchGoogleBooks(_searchRepository)
        .call(FetchGoogleBooksParams(event.value))
        .then(
      (resp) {
        if (resp.isFailure) {
          log("Failure ${resp.failure}");
          // TODO
        } else {
          log("Success: ${resp.books.length}");
          emit(BrowseState.filled(resp.books));
        }
      },
    );
  }

  void _onAddBookRequested(
    AddBookRequested event,
    Emitter<BrowseState> emit,
  ) async {
    log("...Adding book ${event.bookId} with status ${event.status.name}");

    await AddBook(_searchRepository)
        .call(AddBookParams(event.userId, event.bookId, event.status))
        .then((resp) {
      if (resp.isFailure) {
        log("Failure ${resp.failure}");
        // TODO
      } else {
        log("Success");
        final books = state.books
            .map((e) => e.id == resp.book.id ? resp.book : e)
            .toList();
        emit(BrowseState.openedBook(books, resp.book));
      }
    });
  }

  void _onOpenBookRequested(
    OpenBookRequested event,
    Emitter<BrowseState> emit,
  ) {
    emit(BrowseState.openedBook(state.books, event.book));
  }
}
