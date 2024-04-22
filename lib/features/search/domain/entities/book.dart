import 'package:equatable/equatable.dart';
import 'package:lectura/core/enums.dart';

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
    this.infoLink,
    this.subtitle,
    this.language,
    this.mainCategory,
    this.pageCount,
    this.publisher,
    this.publisherDate,
    this.thumbnail,
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
    String? infoLink,

    String? subtitle,
    String? publisher,
    String? publisherDate,
    int? pageCount,
    String? mainCategory,
    String? thumbnail,
    String? language,
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
      infoLink: infoLink ?? this.infoLink,
      subtitle: subtitle ?? this.subtitle,
      publisher: publisher ?? this.publisher,
      pageCount: pageCount ?? this.pageCount,
      mainCategory: mainCategory ?? this.mainCategory,
      thumbnail: thumbnail ?? this.thumbnail,
      language: language ?? this.language,
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
  final String? infoLink;

  final String? subtitle;
  final String? publisher;
  final String? publisherDate;
  final int? pageCount;
  final String? mainCategory;
  final String? thumbnail;
  final String? language;

  final BookStatus status;

  @override
  List<Object> get props => [
    id,
    status,
  ];
}
