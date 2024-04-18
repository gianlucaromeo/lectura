import 'package:flutter/material.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/common/presentation/widgets/book_image.dart';
import 'package:lectura/features/search/domain/entities/book.dart';

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
      child: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  10.0.verticalSpace,

                  /* Currently, cannot find a book with rating from the API

                  if (book.averageRating != null && book.ratingCount != null)
                    Padding(
                      padding: 4.0.onlyBottom,
                      child: Row(children: [
                        ...List.generate(
                          5,
                          (i) {
                            if (i < book.averageRating!) {
                              return const Icon(
                                Icons.star,
                                size: 12.0,
                              );
                            } else if (i < book.averageRating!.ceil()) {
                              return const Icon(
                                Icons.star_half,
                                size: 12.0,
                              );
                            } else {
                              return const Icon(Icons.star_border, size: 12.0);
                            }
                          },
                        ),
                      ]),
                    ),
                    */

                  Text(
                    book.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
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
