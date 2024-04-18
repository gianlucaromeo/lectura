import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/common/presentation/pages/page_skeleton.dart';
import 'package:lectura/features/common/presentation/widgets/book_image.dart';
import 'package:lectura/features/search/domain/entities/book.dart';

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

                    Text(
                      widget.book.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    25.0.verticalSpace,

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
                    // TODO
                  },
                  child: const Text("***ADD"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
