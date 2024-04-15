import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/profile/domain/entities/book.dart';
import 'package:lectura/features/search/domain/repositories/search_repository.dart';
import 'package:lectura/features/search/domain/use_cases/fetch_google_books.dart';
import 'package:rxdart/rxdart.dart';

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

sealed class BrowseEvent {}

final class BrowseInputChanged extends BrowseEvent {
  BrowseInputChanged(this.value);

  final String? value;
}

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  BrowseBloc(SearchRepository searchRepository)
      : _searchRepository = searchRepository,
        super(BrowseState.empty()) {
    on<BrowseInputChanged>(
      _onBrowseInputChanged,
      transformer: _debounceSequential(const Duration(milliseconds: 300)),
    );
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

    List<Book> books = List.empty(growable: true);

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
}
