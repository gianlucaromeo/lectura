import 'package:equatable/equatable.dart';
import 'package:lectura/features/search/domain/entities/book_status.dart';

class Book extends Equatable {
  const Book({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.authors,
    required this.description,
    this.averageRating,
    this.ratingCount,
    this.categories,
    this.status = BookStatus.unknown,
  });

  Book copyWith({
    String? id,
    String? imagePath,
    String? title,
    List<String>? authors,
    String? description,
    double? averageRating,
    int? ratingCount,
    BookStatus? status,
    List<String>? categories,
  }) {
    return Book(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      description: description ?? this.description,
      averageRating: averageRating ?? this.averageRating,
      ratingCount: ratingCount ?? this.ratingCount,
      status: status ?? this.status,
      categories: categories ?? this.categories,
    );
  }

  final String id;
  final String imagePath;
  final String title;
  final List<String>? authors;
  final List<String>? categories;
  final String description;

  final double? averageRating;
  final int? ratingCount;

  final BookStatus status;

  @override
  List<Object> get props => [
    id,
    status,
  ];
}
