import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum BrowseStatus {
  empty,
}

class BrowseState extends Equatable {
  const BrowseState._();

  const BrowseState.empty();

  @override
  List<Object?> get props => [];
}

sealed class BrowseEvent {}

final class BrowseInputChanged extends BrowseEvent {
  BrowseInputChanged(this.value);

  final String? value;
}

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  BrowseBloc() : super(const BrowseState.empty()) {
    on<BrowseInputChanged>(_onBrowseInputChanged);
  }

  void _onBrowseInputChanged(
    BrowseInputChanged event,
    Emitter<BrowseState> emitter,
  ) {
    log("Browsing: ${event.value}");
  }
}
