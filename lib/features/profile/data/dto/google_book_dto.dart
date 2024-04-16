import 'package:lectura/core/convertible_dto.dart';
import 'package:lectura/features/profile/domain/entities/book.dart';

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
    this.smallImageLink,
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
  final String? smallImageLink;
  final String? language;
  final String? infoLink;

  GoogleBookVolumeInfoDto.fromMap(Map<String, dynamic> json)
      : title = json["title"],
        subtitle = json["subtitle"],
        authors = [], // TODO
        publisher = json["publisher"],
        publisherDate = json["publisherDate"],
        description = json["description"],
        pageCount = json["pageCount"],
        mainCategory = json["mainCategory"],
        categories = [], // TODO
        averageRating = (json["averageRating"] as num?)?.toDouble(),
        ratingCount = json["ratingCount"],
        smallImageLink = json["imageLinks"]?["smallThumbnail"],
        language = json["language"],
        infoLink = json["infoLink"];
}

class GoogleBookDto extends ConvertibleDto<Book> {
  const GoogleBookDto({
    this.id,
    required this.volumeInfo,
  });

  final String? id;
  final GoogleBookVolumeInfoDto volumeInfo;

  factory GoogleBookDto.fromJson(Map<String, dynamic> json) {
    return GoogleBookDto(
      id: json["id"],
      volumeInfo: GoogleBookVolumeInfoDto.fromMap(json["volumeInfo"]),
    );
  }

  @override
  Book toEntity() {
    return Book(
      id: id,
      imagePath: volumeInfo.smallImageLink,
      title: volumeInfo.title,
      authors: volumeInfo.authors,
      description: volumeInfo.description,
    );
  }
}
