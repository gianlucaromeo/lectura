import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/auth/bloc/login/login_bloc.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/features/common/presentation/widgets/book_image.dart';
import 'package:lectura/features/search/domain/entities/book.dart';
import 'package:lectura/features/search/domain/entities/book_status.dart';
import 'package:lectura/features/search/presentation/bloc/browse_bloc.dart';

@RoutePage()
class BookPage extends StatefulWidget {
  const BookPage({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return LecturaPage(
      title: widget.book.title,
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
                      imagePath: widget.book.imagePath,
                      imageSize: BookImageSize.big,
                    ),
                    25.0.verticalSpace,

                    /// TITLE
                    Text(
                      widget.book.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    25.0.verticalSpace,

                    /// STATUS
                    Container(
                      padding: [3.0, 10.0].verticalHorizontal,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Text(
                        widget.book.status.name,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                    25.0.verticalSpace,

                    /// DESCRIPTION
                    Text(
                      widget.book.description,
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
                    final userId = context.read<LoginBloc>().state.user!.id!;
                    context.read<BrowseBloc>().add(
                          AddBookRequested(
                            userId,
                            widget.book.id,
                            BookStatus.read,
                          ),
                        );
                  },
                  child: const Text("***I read it!"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
