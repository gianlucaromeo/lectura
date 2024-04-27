import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/enums.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/features/library/presentation/widgets/user_book.dart';
import 'package:lectura/features/search/presentation/bloc/browse_bloc.dart';

@RoutePage()
class LibraryPage extends StatelessWidget {
  LibraryPage({super.key});

  final _allStatus = [
    BookStatus.read,
    BookStatus.currentlyReading,
    BookStatus.toRead,
  ];

  @override
  Widget build(BuildContext context) {
    log("Build", name: "LibraryPage");
    log("Provider: ${context.read<BrowseBloc>().state}", name: "LibraryPage");

    return LecturaPage(
      title: context.l10n.library_page__title,
      body: Padding(
          padding: [20.0, 20.0, 20.0, 0.0].fromLTRB,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...context
                    .watch<BrowseBloc>()
                    .state
                    .userBooks
                    .map((e) => UserBook(book: e, onTap: () {}))
              ],
            ),
          )),
    );
  }
}
