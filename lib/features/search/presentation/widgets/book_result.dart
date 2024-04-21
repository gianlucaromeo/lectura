import 'package:flutter/material.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/common/presentation/widgets/book_image.dart';
import 'package:lectura/features/search/domain/entities/book.dart';
import 'package:lectura/core/enums.dart';

class BookResult extends StatelessWidget {
  const BookResult({
    super.key,
    required this.book,
    this.onTap,
  });

  final Book book;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap?.call(),
      child: Padding(
        padding: 10.0.vertical,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// IMAGE
            BookImage(
              imagePath: book.imagePath,
              imageSize: BookImageSize.small,
            ),
            25.0.horizontalSpace,

            /// TITLE - AUTHOR(S) - DESCRIPTION
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold,),
                  ),
                  4.0.verticalSpace,

                  /// AUTHORS
                  if (book.authors?.isNotEmpty == true)
                    Padding(
                      padding: 10.0.onlyBottom,
                      child: Text(
                        book.authors!.join(", "),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),

                  /// DESCRIPTION
                  Text(
                    book.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  15.0.verticalSpace,

                  /// STATUS
                  if (book.status != BookStatus.unknown)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "#${book.status.name}",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
