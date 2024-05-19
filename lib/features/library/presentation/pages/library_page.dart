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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide.none,
                    ),
                    side: BorderSide(color: Theme.of(context).colorScheme.surface)
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
                child: BlocBuilder<BrowseBloc, BrowseState>(
                  buildWhen: (previous, current) =>
                      previous.userBooks != current.userBooks,
                  builder: (context, state) {
                    final filteredUserBooks = state.userBooks
                        .where((e) => selectedSegments.contains(e.status))
                        .map(
                          (e) => UserBook(
                            book: e,
                            onTap: () {
                              context
                                  .read<BrowseBloc>()
                                  .add(OpenBookRequested(e));
                              AutoRouter.of(context).push(Routes.bookRoute);
                            },
                          ),
                        );

                    if (filteredUserBooks.isEmpty) {
                      return Padding(
                        padding: 20.0.horizontal,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context.l10n.library_page__no_books_info,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                            15.0.verticalSpace,
                            TextButton.icon(
                              icon: const Icon(Icons.search),
                              label:
                                  Text(context.l10n.library_page__go_to_search),
                              onPressed: () {
                                AutoRouter.of(context)
                                    .navigate(Routes.searchWrapperRoute);
                              },
                            ),
                          ],
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ...filteredUserBooks,
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
