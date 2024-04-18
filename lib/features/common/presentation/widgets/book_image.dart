import 'package:flutter/material.dart';

enum BookImageSize { small, medium, big }

extension on BookImageSize {
  Size get size {
    switch (this) {
      case BookImageSize.small:
        return const Size(70.0, 100.0);
      case BookImageSize.medium:
        return const Size(100.0, 125.0);
      case BookImageSize.big:
        return const Size(135.0, 100.0);
    }
  }
}

class BookImage extends StatelessWidget {
  const BookImage({
    super.key,
    required this.imagePath,
    required this.imageSize,
  });

  final String imagePath;
  final BookImageSize imageSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageSize.size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.2),
            blurRadius: 4.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: ClipRRect(
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
