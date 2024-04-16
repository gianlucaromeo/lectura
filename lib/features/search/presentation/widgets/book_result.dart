import 'package:flutter/material.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/profile/domain/entities/book.dart';

class BookResult extends StatelessWidget {
  const BookResult({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    if (book.title?.isEmpty == true) {
      return const SizedBox();
    }

    return SizedBox(
      child: Row(
        children: [
          /// IMAGE
          () {
            if (book.imagePath != null) {
              return Image.network(book.imagePath!);
            } else {
              return const SizedBox();
            }
          }(),

          25.0.horizontalSpace,

          /// TITLE - AUTHOR(S) - DESCRIPTION
          Expanded(
            child: Column(
              children: [
                Text(
                  book.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  book.description ?? "no descr",
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
