import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/enums.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/routes.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/features/library/presentation/widgets/user_book.dart';
import 'package:lectura/features/search/presentation/bloc/browse_bloc.dart';

@RoutePage()
class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  Set<BookStatus> selectedSegments = {
    BookStatus.read,
    BookStatus.currentlyReading,
    BookStatus.toRead,
  };

  @override
  Widget build(BuildContext context) {
    log("Build", name: "LibraryPage");
    log("Provider: ${context.read<BrowseBloc>().state}", name: "LibraryPage");

    return LecturaPage(
      title: context.l10n.library_page__title,
      body: Padding(
          padding: [20.0, 20.0, 20.0, 0.0].fromLTRB,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: SegmentedButton(
                  multiSelectionEnabled: true,
                  segments: [
                    ButtonSegment(
                      value: BookStatus.read,
                      label: Text(context.l10n.book_status__read),
                    ),
                    ButtonSegment(
                      value: BookStatus.currentlyReading,
                      label: Text(context.l10n.book_status__currently_reading),
                    ),
                    ButtonSegment(
                      value: BookStatus.toRead,
                      label: Text(context.l10n.book_status__to_read),
                    ),
                  ],
                  style: SegmentedButton.styleFrom(
                    padding: 6.0.horizontal, // TODO
                  ),
                  selected: selectedSegments,
                  emptySelectionAllowed: false,
                  onSelectionChanged: (newSelection) {
                    setState(() {
                      selectedSegments = newSelection;
                    });
                  },
                  showSelectedIcon: false,
                ),
              ),
              20.0.verticalSpace,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...context
                          .watch<BrowseBloc>()
                          .state
                          .userBooks
                          .where((e) => selectedSegments.contains(e.status))
                          .map((e) => UserBook(book: e, onTap: () {
                            context.read<BrowseBloc>().add(OpenBookRequested(e));
                            AutoRouter.of(context).push(Routes.bookRoute);
                      }))
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
