import 'package:lectura/core/convertible_dto.dart';
import 'package:lectura/core/extensions.dart';
import 'package:lectura/features/search/domain/entities/book.dart';

class GoogleBookVolumeInfoDto {
  const GoogleBookVolumeInfoDto({
    this.title,
    this.subtitle,
    this.authors,
    this.publisher,
    this.publisherDate,
    this.description,
    this.pageCount,
    this.mainCategory,
    this.categories,
    this.averageRating,
    this.ratingCount,
    this.thumbnail,
    this.language,
    this.infoLink,
  });

  final String? title;
  final String? subtitle;
  final List<String>? authors;
  final String? publisher;
  final String? publisherDate;
  final String? description;
  final int? pageCount;
  final String? mainCategory;
  final List<String>? categories;
  final double? averageRating;
  final int? ratingCount;
  final String? thumbnail;
  final String? language;
  final String? infoLink;

  GoogleBookVolumeInfoDto.fromMap(Map<String, dynamic> json)
      : title = json["title"],
        subtitle = json["subtitle"],
        authors = (json["authors"] as List?)?.cast<String>(),
        publisher = json["publisher"],
        publisherDate = json["publisherDate"],
        description = json["description"],
        pageCount = json["pageCount"],
        mainCategory = json["mainCategory"],
        categories =
            (json["categories"] as List?)?.cast<String>(),
        averageRating = (json["averageRating"] as num?)?.toDouble(),
        ratingCount = json["ratingCount"],
        thumbnail = json["imageLinks"]?["thumbnail"],
        language = json["language"],
        infoLink = json["infoLink"];
}

class GoogleBookResultDto extends ConvertibleDto<Book> {
  const GoogleBookResultDto({
    this.id,
    required this.volumeInfo,
  });

  final String? id;
  final GoogleBookVolumeInfoDto volumeInfo;

  factory GoogleBookResultDto.fromJson(Map<String, dynamic> json) {
    return GoogleBookResultDto(
      id: json["id"],
      volumeInfo: GoogleBookVolumeInfoDto.fromMap(json["volumeInfo"]),
    );
  }

  @override
  Book toEntity() {
    if (!isValid) {
      throw Exception(
          "Book.toEntity has been called but book.isValid is false");
    }
    return Book(
      id: id!,
      imagePath: volumeInfo.thumbnail!,
      title: volumeInfo.title!,
      authors: volumeInfo.authors,
      description: volumeInfo.description!,
      averageRating: volumeInfo.averageRating,
      ratingCount: volumeInfo.ratingCount,
      categories: volumeInfo.categories,
    );
  }

  GoogleBookResultDto.fromEntity(Book e)
      : id = e.id,
        volumeInfo = GoogleBookVolumeInfoDto(
          categories: e.categories,
          authors: e.authors,
          averageRating: e.averageRating,
          description: e.description,
          infoLink: e.infoLink,
          language: e.language,
          mainCategory: e.mainCategory,
          pageCount: e.pageCount,
          publisher: e.publisher,
          publisherDate: e.publisherDate,
          ratingCount: e.ratingCount,
          subtitle: e.subtitle,
          thumbnail: e.thumbnail,
          title: e.title,
        );
}
