import 'package:lectura/core/convertible_dto.dart';
import 'package:lectura/features/profile/domain/entities/book.dart';

class GoogleBookDto extends ConvertibleDto<Book> {
  const GoogleBookDto({
    this.title,
    this.authors,
    this.description,
  });

  final String? title;
  final List<String>? authors;
  final String? description;

  factory GoogleBookDto.fromJson(Map<String, dynamic> json) {
    return GoogleBookDto(
      title: json["volumeInfo"]["title"],
      // TODO
    );
  }

  @override
  Book toEntity() {
    return Book(
      title: title,
      authors: authors,
      description: description,
    );
  }
}
