import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/core/utils.dart';
import 'package:lectura/features/auth/bloc/login/login_bloc.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/features/common/presentation/widgets/app_dialog.dart';
import 'package:lectura/features/common/presentation/widgets/book_image.dart';
import 'package:lectura/core/enums.dart';
import 'package:lectura/features/search/domain/entities/book.dart';
import 'package:lectura/features/search/presentation/bloc/browse_bloc.dart';

@RoutePage()
class BookPage extends StatefulWidget {
  const BookPage({
    super.key,
  });

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    final browseBlocBook = context.read<BrowseBloc>().state.openedBook;

    if (browseBlocBook == null) {
      return const SizedBox(); // TODO
    }

    final statusInfo = [
      [context.l10n.book_status__read, BookStatus.read],
      [
        context.l10n.book_status__currently_reading,
        BookStatus.currentlyReading
      ],
      [context.l10n.book_status__to_read, BookStatus.toRead],
    ];

    return LecturaPage(
      showBackIcon: true,
      padding: 20.0.horizontal,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            20.0.verticalSpace,

            /// IMAGE, TITLE, AUTHORS, STATUS, DESCRIPTION
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// HEADER
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// IMAGE
                        BookImage(
                          imagePath: browseBlocBook.imagePath,
                          imageSize: BookImageSize.big,
                        ),
                        25.0.horizontalSpace,

                        /// TITLE AUTHORS CATEGORIES
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                browseBlocBook.title,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              7.0.verticalSpace,

                              /// AUTHORS
                              () {
                                if (browseBlocBook.authors?.isNotEmpty ==
                                    true) {
                                  return Padding(
                                    padding: 15.0.onlyBottom,
                                    child: Text(
                                      browseBlocBook.authors!.join(", "),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }
                                return const SizedBox();
                              }(),

                              15.0.verticalSpace,

                              /// CATEGORIES
                              () {
                                if (browseBlocBook.categories?.isNotEmpty ==
                                    true) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        context.l10n.book_page__category,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      7.0.verticalSpace,
                                      Text(
                                        browseBlocBook.categories!.join(", "),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  );
                                }
                                return 0.0.verticalSpace;
                              }(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    15.0.verticalSpace,

                    /// STATUS
                    BlocBuilder<BrowseBloc, BrowseState>(
                      builder: (context, state) {
                        final book = state.openedBook!;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            () {
                              if (book.status == BookStatus.unknown) {
                                return const SizedBox();
                              } else {
                                return Chip(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                    side: const BorderSide(
                                      width: 0.0,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  elevation: 4.0, // TODO Find better color
                                  label: Text(
                                    getStatusText(context, book.status),
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                );
                              }
                            }(),
                            25.0.verticalSpace,

                            /// EDIT / ADD / REMOVE {BOTTOM SHEET}
                            TextButton(
                              onPressed: () {
                                _buildShowModalBottomSheet(
                                  context,
                                  statusInfo,
                                  book.status,
                                  book,
                                );
                              },
                              child: Text(
                                book.status == BookStatus.unknown
                                    ? context.l10n.book_status__add
                                    : context.l10n.book_status__change,
                              ),
                            ),
                            const Spacer(),

                            /// DELETE
                            if (book.status != BookStatus.unknown)
                              IconButton(
                                onPressed: () {
                                  showAppConfirmationDialog(
                                    context: context,
                                    title:
                                        context.l10n.dialog__delete_book__title,
                                    content: context
                                        .l10n.dialog__delete_book__content,
                                    confirmationOption: context.l10n
                                        .dialog__delete_book__confirm_option,
                                    denyOption: context
                                        .l10n.dialog__delete_book__deny_option,
                                    onConfirm: () {
                                      context.read<BrowseBloc>().add(
                                            BookDeleteRequested(
                                              userId: context
                                                  .read<LoginBloc>()
                                                  .state
                                                  .user!
                                                  .id!,
                                              bookId: book.id,
                                            ),
                                          );
                                    },
                                    onDeny: () {},
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                          ],
                        );
                      },
                    ),
                    15.0.verticalSpace,

                    /// DESCRIPTION
                    Text(
                      browseBlocBook.description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _buildShowModalBottomSheet(
    BuildContext context,
    List<List<Object>> statusInfo,
    BookStatus status,
    Book book,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: 35.0.all,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// TITLE
                    Text(
                      context.l10n.book_status__select_status,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    25.0.verticalSpace,

                    /// BUTTONS
                    ...List.generate(
                      3,
                      (i) {
                        return SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: 15.0.onlyBottom,
                            child: OutlinedButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      statusInfo[i][1] as BookStatus == status
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Colors.transparent,
                                  foregroundColor: statusInfo[i][1]
                                              as BookStatus ==
                                          status
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.primary,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        height: 3.0,
                                      )),
                              onPressed: () {
                                final userId =
                                    context.read<LoginBloc>().state.user!.id!;

                                context.read<BrowseBloc>().add(
                                      AddBookRequested(
                                        userId,
                                        book.id,
                                        statusInfo[i][1] as BookStatus,
                                      ),
                                    );

                                // Close bottom bar
                                AutoRouter.of(context).maybePop();
                              },
                              child: Text(
                                statusInfo[i][0] as String,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
