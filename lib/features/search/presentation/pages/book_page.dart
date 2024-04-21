import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/auth/bloc/login/login_bloc.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/features/common/presentation/widgets/book_image.dart';
import 'package:lectura/core/enums.dart';
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
    final book = context.read<BrowseBloc>().state.openedBook;

    if (book == null) {
      return const SizedBox(); // TODO
    }

    final statusInfo = [
      ["***read", BookStatus.read],
      ["***reading now", BookStatus.currentlyReading],
      ["***to read", BookStatus.toRead],
    ];

    return LecturaPage(
      title: book.title,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// IMAGE
                    BookImage(
                      imagePath: book.imagePath,
                      imageSize: BookImageSize.big,
                    ),
                    25.0.verticalSpace,

                    /// TITLE
                    Text(
                      book.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    25.0.verticalSpace,

                    /// STATUS
                    Builder(
                      builder: (context) {
                        return Container(
                          padding: [3.0, 10.0].verticalHorizontal,
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: Text(
                            context
                                .watch<BrowseBloc>()
                                .state
                                .openedBook!
                                .status
                                .name,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        );
                      },
                    ),

                    25.0.verticalSpace,

                    /// DESCRIPTION
                    Text(
                      book.description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: 15.0.all,
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 3.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                              (i) {
                                return OutlinedButton(
                                  onPressed: () {
                                    final userId = context
                                        .read<LoginBloc>()
                                        .state
                                        .user!
                                        .id!;

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
                                  child: Text(statusInfo[i][0] as String),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child:

                      /// ADD OR EDIT
                      Builder(
                    builder: (context) {
                      return Text(
                        context.watch<BrowseBloc>().state.openedBook!.status ==
                                BookStatus.unknown
                            ? "**ADD"
                            : "**EDIT",
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
